const express = require("express");
const router = express.Router();
const path = require("path");

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

// admin/product.html
router.get("/product.html", (req, res) => {
  const isAdminPromise = new Promise((resolve) => {
    let userEmail;
    if (req.query.adminEmail === undefined) {
      userEmail = "";
    } else {
      userEmail = req.query.adminEmail;
    }
    client.get(userEmail, async (error, rep) => {
      if (error) {
        console.log("client.get error:", error);
      }
      if (rep) {
        resolve(true);
      }
      resolve(false);
    });
  });

  isAdminPromise.then((isAdmin) => {
    if (isAdmin) {
      res.sendFile(path.join(__dirname, "../../public/views/product.html"));
    } else {
      res.sendFile(path.join(__dirname, "../../public/views/nopermission.html"));
    }
  });
});

// admin/campaign.html
router.get("/campaign.html", (req, res) => {
  const isAdminPromise = new Promise((resolve) => {
    let userEmail;
    if (req.query.adminEmail === undefined) {
      userEmail = "";
    } else {
      userEmail = req.query.adminEmail;
    }
    client.get(userEmail, async (error, rep) => {
      if (error) {
        console.log("client.get error:", error);
      }
      if (rep) {
        resolve(true);
      }
      resolve(false);
    });
  });

  isAdminPromise.then((isAdmin) => {
    if (isAdmin) {
      res.sendFile(path.join(__dirname, "../../public/views/campaign.html"));
    } else {
      res.sendFile(path.join(__dirname, "../../public/views/nopermission.html"));
    }
  });
});

module.exports = { router: router };
