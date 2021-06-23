const express = require("express");
const router = express.Router();

const colorMapReverse = {
  FFFFFF: "White",
  FFDDDD: "Pink",
  DDFFBB: "Green",
  DDF0FF: "Blue",
  CCCCCC: "Grey",
  BB7744: "Brown",
  334455: "DarkBlue"
};

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

function queryDB (req, table, column, value, returnType) {
  // return Type: 'length', 'tableContent'
  return new Promise((resolve) => {
    let checkExistSql = "";
    let sqlCondition = `${column} = '${value}'`;
    if (value === "IS NOT NULL") {
      sqlCondition = `${column} ${value}`;
    }
    if (column === "Title") {
      sqlCondition = `${column} LIKE '%${value}%'`;
    }

    if (table === "user") {
      checkExistSql = `SELECT * FROM ${table} WHERE ` + sqlCondition;
    } else {
      checkExistSql =
        `SELECT * FROM ${table} WHERE ` +
        sqlCondition +
        " ORDER BY Product_ID;";
    }
    // console.log(returnType, checkExistSql);
    req.app.get("pool").query(checkExistSql, (err, results) => {
      if (err) throw err;
      if (returnType === "length") resolve(results.length);
      if (returnType === "tableContent") resolve(results);
    });
  });
}

function buildProduct (RowDataPacket) {
  const product = {
    id: RowDataPacket.Product_ID,
    title: RowDataPacket.Title,
    description: RowDataPacket.Description,
    price: RowDataPacket.Price,
    texture: RowDataPacket.Texture,
    wash: RowDataPacket.Wash,
    place: RowDataPacket.Place,
    note: RowDataPacket.Note,
    story: RowDataPacket.Story,
    colors: [],
    sizes: [],
    variants: [],
    main_image: RowDataPacket.Main_image,
    images: [
      RowDataPacket.Other_image_1,
      RowDataPacket.Other_image_2,
      RowDataPacket.Other_image_3,
      RowDataPacket.Other_image_4
    ]
  };
  return product;
}

function buildVariant (RowDataPacket) {
  const variant = {
    color_code: RowDataPacket.Color_code,
    size: RowDataPacket.Size,
    stock: RowDataPacket.Stock
  };
  return variant;
}

function chekcInSet (RowDataPacket, valueSet, column) {
  if (!valueSet.has(RowDataPacket[column])) {
    valueSet.add(RowDataPacket[column]);
  }
  return valueSet;
}

async function buildProductJson (
  req,
  categoryItem,
  reqPage,
  searchKeyword,
  detailId
) {
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
  const json = { data: [], page: 0, product: 0 };

  const prdocutTablePromise = new Promise((resolve) => {
    let prdocutTableContent;

    // set SQL query syntax
    if (detailId) {
      client.get("searchProductId:" + detailId, async (error, rep) => {
        if (error) {
          console.log("client.get error:", error);
        }
        if (rep) {
          prdocutTableContent = JSON.parse(rep);
          resolve(prdocutTableContent);
        } else {
          prdocutTableContent = await queryDB(
            req,
            "product",
            "Product_ID",
            parseInt(detailId),
            "tableContent"
          );
          client.set(
            "searchProductId:" + detailId,
            JSON.stringify(prdocutTableContent),
            (error, result) => {
              if (error) {
                console.log("client.set error:", error);
              }
            }
          );
          resolve(prdocutTableContent);
        }
      });
    } else if (searchKeyword) {
      client.get("searchKeyword:" + searchKeyword, async (error, rep) => {
        if (error) {
          console.log("client.get error:", error);
        }
        if (rep) {
          prdocutTableContent = JSON.parse(rep);
          resolve(prdocutTableContent);
        } else {
          prdocutTableContent = await queryDB(
            req,
            "product",
            "Title",
            searchKeyword,
            "tableContent"
          );
          client.set(
            "searchKeyword:" + searchKeyword,
            JSON.stringify(prdocutTableContent),
            (error, result) => {
              if (error) {
                console.log("client.set error:", error);
              }
            }
          );
          resolve(prdocutTableContent);
        }
      });
    } else {
      client.get("searchCategory:" + categoryItem, async (error, rep) => {
        if (error) {
          console.log("client.get error:", error);
        }
        if (rep) {
          prdocutTableContent = JSON.parse(rep);
          resolve(prdocutTableContent);
        } else {
          prdocutTableContent = await queryDB(
            req,
            "product",
            "Category",
            categoryItem,
            "tableContent"
          );
          client.set(
            "searchCategory:" + categoryItem,
            JSON.stringify(prdocutTableContent),
            (error, result) => {
              if (error) {
                console.log("client.set error:", error);
              }
            }
          );
          resolve(prdocutTableContent);
        }
      });
    }
  });

  return prdocutTablePromise.then(async (prdocutTableContent) => {
    const totalProductsNumber = prdocutTableContent.length;

    for (let i = 0; i < totalProductsNumber; i++) {
      json.data.push(buildProduct(prdocutTableContent[i]));
      const variantTableContent = await queryDB(
        req,
        "variant",
        "Product_ID",
        prdocutTableContent[i].Product_ID,
        "tableContent"
      );
      const totalVariantsNumber = variantTableContent.length;

      let allSizes = new Set();
      let allColors = new Set();

      // add variant to product
      for (let j = 0; j < totalVariantsNumber; j++) {
        json.data[i].variants.push(buildVariant(variantTableContent[j]));
        allColors = chekcInSet(variantTableContent[j], allColors, "Color_code");
        allSizes = chekcInSet(variantTableContent[j], allSizes, "Size");
      }

      // set color and size to product
      [...allColors].forEach((colorCode) =>
        json.data[i].colors.push({
          code: colorCode,
          name: colorMapReverse[colorCode]
        })
      );
      json.data[i].sizes = [...allSizes];

      // update product number
      json.product += 1;

      // has paging return logic
      if (parseInt(reqPage) === json.page) {
        if (json.product % 6 === 0 || json.product === totalProductsNumber) {
          json.next_paging = json.page + 1;
          json.data = json.data.slice(json.page * 6);
          if (json.product === totalProductsNumber) delete json.next_paging;
          delete json.page;
          delete json.product;
          return json;
        }
      }

      // no paging return logic
      if (reqPage === undefined) {
        if (json.product === 6 || json.product === totalProductsNumber) {
          json.next_paging = 1;
          if (json.product === totalProductsNumber) delete json.next_paging;
          delete json.page;
          delete json.product;
          if (detailId) json.data = json.data[0];
          return json;
        }
      }

      // json.product % 6 === 0
      if (json.product % 6 === 0) {
        json.page += 1;
      }
    }
  });
}

router.get("/all", (req, res) => {
  const completeJson = buildProductJson(req, "IS NOT NULL", req.query.paging);
  completeJson.then((v) => {
    res.send(JSON.stringify(v));
  });
});

router.get("/women", (req, res) => {
  const completeJson = buildProductJson(req, "Women", req.query.paging);
  completeJson.then((v) => {
    res.send(JSON.stringify(v));
  });
});

router.get("/men", (req, res) => {
  const completeJson = buildProductJson(req, "Men", req.query.paging);
  completeJson.then((v) => {
    res.send(JSON.stringify(v));
  });
});

router.get("/accessories", (req, res) => {
  const completeJson = buildProductJson(req, "Accessories", req.query.paging);
  completeJson.then((v) => {
    res.send(JSON.stringify(v));
  });
});

router.get("/search", (req, res) => {
  const completeJson = buildProductJson(
    req,
    "IS NOT NULL",
    req.query.paging,
    req.query.keyword
  );
  completeJson.then((v) => {
    res.send(JSON.stringify(v));
  });
});

router.get("/details", (req, res) => {
  const completeJson = buildProductJson(
    req,
    "IS NOT NULL",
    req.query.paging,
    undefined,
    req.query.id
  );
  completeJson.then((v) => {
    res.send(JSON.stringify(v));
  });
});

module.exports = { router: router, queryDB: queryDB };
