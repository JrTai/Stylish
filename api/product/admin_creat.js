const express = require("express");
const router = express.Router();
const bodyParser = require("body-parser");
const multer = require("multer");
const uniqid = require("uniqid");
const aws = require("aws-sdk");
const multerS3 = require("multer-s3");

// set .env
require("dotenv").config();

console.log(process.env.S3_SECRET_ACCESS_KEY);
console.log(process.env.S3_ACCESS_KEY);

aws.config.update({
  secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
  accessKeyId: process.env.S3_ACCESS_KEY,
  region: "ap-northeast-1"
});

const s3 = new aws.S3();

router.use(express.static("public"));

router.use(bodyParser.json());
router.use(bodyParser.text());
router.use(bodyParser.urlencoded({ extended: false }));

// use to store 5 upload pic id
let tempPicId = [];

// set color map
const colorMap = {
  White: "FFFFFF",
  Pink: "FFDDDD",
  Green: "DDFFBB",
  Blue: "DDF0FF",
  Grey: "CCCCCC",
  Brown: "BB7744",
  DarkBlue: "334455"
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

function clearAllRedisKeys () {
  client.flushdb(function (err, succeeded) {
    if (err) console.log(err);
    console.log("clear all redis keys: " + succeeded); // will be true if successfull
  });
}

// multer upload to local machine
// const storage = multer.diskStorage({
//   destination: function (req, file, cb) {
//     cb(null, "./public/pics");
//   },
//   filename: function (req, file, cb) {
//     const picId = uniqid();
//     // cb(null, file.fieldname + "-" + Date.now());
//     cb(null, picId + ".jpg");
//     tempPicId.push(picId);
//   }
// });

// multer upload to AWS S3
const storage = multerS3({
  s3: s3,
  bucket: "stylish-henry/pics",
  acl: "public-read",
  contentType: function (req, file, cb) {
    cb(null, file.mimetype);
  },
  metadata: function (req, file, cb) {
    cb(null, { fieldName: file.fieldname });
  },
  key: function (req, file, cb) {
    const picId = uniqid();
    cb(null, picId + ".jpg"); // use Date.now() for unique file keys
    tempPicId.push(picId);
  }
});

// check if product_id exist
router.post("/check_id", (req, res) => {
  // need to check if productId already exist in db
  const checkExistSql = `SELECT COUNT(1) FROM product WHERE Product_ID = '${req.body.product_ID}';`;
  req.app.get("pool").query(checkExistSql, (err, results) => {
    if (err) throw err;
    if (results[0]["COUNT(1)"]) {
      res.send("Product_ID exist");
    } else {
      res.send("Product_ID do not exist, will create Prodcut ID");
    }
  });
});

// insert product into 3 tables in db
router.post("/insertProduct", (req, res) => {
  clearAllRedisKeys();
  const product = {
    Product_ID: req.body.product_ID,
    Category: req.body.category,
    Title: req.body.title,
    Description: req.body.description,
    Price: req.body.price,
    Texture: req.body.texture,
    Wash: req.body.wash,
    Place: req.body.place,
    Note: req.body.note,
    Story: req.body.story,
    Main_image: req.body.mainImg,
    Other_image_1: req.body.otherImg1,
    Other_image_2: req.body.otherImg2,
    Other_image_3: req.body.otherImg3,
    Other_image_4: req.body.otherImg4
  };

  const colors = {
    Color_name: req.body.color,
    Color_code: colorMap[req.body.color]
  };

  const variant = {
    Product_ID: req.body.product_ID,
    Size: req.body.size,
    Stock: req.body.quantity,
    Color_code: colorMap[req.body.color]
  };

  const sql1 = "INSERT INTO product SET ?;";
  req.app.get("pool").query(sql1, product, (err, result) => {
    if (err) throw err;
    // res.send("new product");
  });

  const sql2 = "INSERT INTO variant SET ?;";
  req.app.get("pool").query(sql2, variant, (err, result) => {
    if (err) throw err;
    // res.send("new product");
  });

  // need to check if colors already exist in db
  const checkExistSql = `SELECT COUNT(1) FROM colors WHERE Color_code = '${
    colorMap[req.body.color]
  }';`;
  req.app.get("pool").query(checkExistSql, (err, results) => {
    if (err) throw err;
    if (results[0]["COUNT(1)"]) {
      res.send("color exist; new prodcut insert finished");
    } else {
      const sql4 = "INSERT INTO colors SET ?;";
      req.app.get("pool").query(sql4, colors, (err, result) => {
        if (err) throw err;
        res.send("new color; new product insert finished");
      });
    }
  });
});

// insert product into 3 tables in db
router.post("/insertCampaign", (req, res) => {
  clearAllRedisKeys();
  const campaignData = {
    Product_ID: req.body.product_ID,
    Picture: req.body.campaignImg,
    Story: req.body.story
  };

  const sql1 = "INSERT INTO campaign SET ?;";
  req.app.get("pool").query(sql1, campaignData, (err, result) => {
    if (err) throw err;
  });
  res.send("new campaign");
});

// insert variant
router.post("/insertVariant", (req, res) => {
  clearAllRedisKeys();
  const colors = {
    Color_name: req.body.color,
    Color_code: colorMap[req.body.color]
  };

  // need to check if colors already exist in db
  const checkExistSql = `SELECT COUNT(1) FROM colors WHERE Color_code = '${
    colorMap[req.body.color]
  }';`;
  req.app.get("pool").query(checkExistSql, (err, results) => {
    if (err) throw err;
    if (results[0]["COUNT(1)"]) {
      console.log("color exist; new prodcut insert finished");
    } else {
      const sql1 = "INSERT INTO colors SET ?;";
      req.app.get("pool").query(sql1, colors, (err, result) => {
        if (err) throw err;
        console.log("new color; new product insert finished");
      });
    }
  });

  const variant = {
    Product_ID: req.body.product_ID,
    Size: req.body.size,
    Stock: req.body.quantity,
    Color_code: colorMap[req.body.color]
  };

  const idSizeColorSql = `WHERE Product_ID = '${
    req.body.product_ID
  }' AND Color_code = '${colorMap[req.body.color]}' AND Size = '${
    req.body.size
  }'`;

  // check row where id, size, color
  const checkVariantExistSql = "SELECT COUNT(1) FROM variant " + idSizeColorSql;
  req.app.get("pool").query(checkVariantExistSql, (err, results) => {
    if (err) throw err;
    if (results[0]["COUNT(1)"]) {
      // if row exist, update by add more
      // update current stock then add input stock
      const updateSql =
        `UPDATE variant SET Stock = Stock + ${req.body.quantity} ` +
        idSizeColorSql;

      req.app.get("pool").query(updateSql, variant, (err, result) => {
        if (err) throw err;
      });
      res.send("variant exist, update variant");
    } else {
      // if row not exist, just simplely insert
      const sql2 = "INSERT INTO variant SET ?;";
      req.app.get("pool").query(sql2, variant, (err, result) => {
        if (err) throw err;
        res.send("new variant insert finished");
      });
    }
  });
});

// upload photo
router.post("/uploadPhoto", function (req, res, next) {
  const upload = multer({
    storage: storage,
    limits: { fileSize: "50mb" }
  }).fields([
    { name: "main_image", maxCount: 1 },
    { name: "other_image_1", maxCount: 1 },
    { name: "other_image_2", maxCount: 1 },
    { name: "other_image_3", maxCount: 1 },
    { name: "other_image_4", maxCount: 1 }
  ]);

  // console.log("REQ", req.data); //file is there in the body
  upload(req, res, function (err) {
    console.log("upload photo error message:", err);
    if (err) {
      return res.end("Error uploading file.");
    }
    // set tempPicId back to empty array for next time use
    const thisUpload = tempPicId.slice();
    tempPicId = [];
    res.send(thisUpload);
    // res.end("File is uploaded");
  });
});

// upload photo for campaign
router.post("/uploadPhotoCampaign", function (req, res, next) {
  const upload = multer({
    storage: storage,
    limits: { fileSize: "50mb" }
  }).fields([{ name: "campaign_image", maxCount: 1 }]);

  // console.log("REQ", req.data); //file is there in the body
  upload(req, res, function (err) {
    console.log("upload photo error message:", err);
    if (err) {
      return res.end("Error uploading file.");
    }
    // set tempPicId back to empty array for next time use
    const thisUpload = tempPicId.slice();
    tempPicId = [];
    res.send(thisUpload);
    // res.end("File is uploaded");
  });
});

module.exports = { router: router };
