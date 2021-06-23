const express = require("express");
const router = express.Router();

const queryDB = require(".././product/product_api").queryDB;

// production redis url
let redisUrl = process.env.REDIS_URL;
if (process.env.ENVIRONMENT === "development") {
  redisUrl = "redis://127.0.0.1";
}

// redis setup
const client = require("redis").createClient(redisUrl);
const Redis = require("ioredis");
// eslint-disable-next-line no-unused-vars
const redis = new Redis(redisUrl);

async function buildCampaigns (req) {
  // set rate limit
  async function isOverLimit (ip) {
    try {
      await client.incr(ip);
      client.expire(ip, process.env.RATE_WINDOW);
    } catch (err) {
      console.error("isOverLimit: could not increment key");
      throw err;
    }
    return new Promise((resolve) => {
      client.get(ip, async (error, rep) => {
        if (error) {
          console.log("client.get error:", error);
        }
        if (parseInt(rep) > parseInt(process.env.RATE_LIMIT)) {
          resolve(true);
        }
        resolve(false);
      });
    });
  }
  // check rate limit
  const overLimit = await isOverLimit(req.ip);
  if (overLimit) {
    return { warning: "Too Many Requests!" };
  }

  const campaignTablePromise = new Promise((resolve) => {
    let campaignTableContent;
    client.get("campaignTableContent", async (error, rep) => {
      if (error) {
        console.log("client.get error:", error);
      }
      if (rep) {
        campaignTableContent = JSON.parse(rep);
        resolve(campaignTableContent);
      } else {
        campaignTableContent = await queryDB(
          req,
          "campaign",
          "Campaign_ID",
          "IS NOT NULL",
          "tableContent"
        );
        client.set(
          "campaignTableContent",
          JSON.stringify(campaignTableContent),
          (error, result) => {
            if (error) {
              console.log("client.set error:", error);
            }
          }
        );
        resolve(campaignTableContent);
      }
    });
  });

  return campaignTablePromise.then((campaignTableContent) => {
    const arr = [];
    campaignTableContent.forEach((RowDataPacket) => {
      const campaign = {
        product_id: RowDataPacket.Product_ID,
        picture: RowDataPacket.Picture,
        story: RowDataPacket.Story
      };
      arr.push(campaign);
    });
    const json = {
      data: arr
    };
    return json;
  });
}

router.get("/campaigns", (req, res) => {
  const completeJson = buildCampaigns(req);
  completeJson.then((v) => {
    res.send(JSON.stringify(v));
  });
});

module.exports = { router: router };
