const express = require("express");
const router = express.Router();
const path = require("path");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const uniqid = require("uniqid");

router.use(bodyParser.json());
router.use(bodyParser.text());
router.use(bodyParser.urlencoded({ extended: false }));

// set signUp async function
const checkEmailAndInsert = require("../.././signInAndOut/signProcess")
  .checkEmailAndInsert;
// set signIn async function
const checkEmailAndPassword = require("../.././signInAndOut/signProcess")
  .checkEmailAndPassword;
// set signIn async function
const getFacebookData = require("../.././signInAndOut/signProcess")
  .getFacebookData;
// set checkAdmin function
const checkAdmin = require("../.././signInAndOut/signProcess").checkAdmin;

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

// check user if admin
router.post("/checkAdmin", async (req, res) => {
  const userTable = await checkAdmin(req, req.body.email);
  let adminId;
  if (userTable[0].Admin) {
    adminId = uniqid();
    client.set(req.body.email, adminId, (error, result) => {
      if (error) {
        console.log("client.set error:", error);
      }
    });
    client.expire(req.body.email, parseInt(process.env.ADMIN_EXPRIE));
  }
  const admin = {
    isAdmin: userTable[0].Admin,
    adminId: adminId,
    email: req.body.email
  };
  res.status(200).send(JSON.stringify(admin));
});

// user sign up GET method
router.get("/signup", (req, res) => {
  res.sendFile(path.join(__dirname, "../../public/views", "signup.html"));
});

// user sign up POST method
router.post("/signup", (req, res) => {
  const addUserResult = checkEmailAndInsert(
    req,
    req.body.name,
    req.body.email,
    req.body.password
  );
  addUserResult.then((OkPacket) => {
    if (OkPacket) {
      const userToken = jwt.sign(
        {
          name: req.body.name,
          email: req.body.email,
          provider: "native",
          picture: null
        },
        process.env.ACCESS_TOKEN_SECRET,
        { expiresIn: process.env.USER_TOKEN_EXPIRE }
      );

      const json = {
        data: {
          access_token: "Bearer " + userToken,
          access_expired: parseInt(process.env.USER_TOKEN_EXPIRE),
          user: {
            id: OkPacket.insertId,
            provider: "native",
            name: req.body.name,
            email: req.body.email,
            picture: null
          }
        }
      };

      req.header.authorization = "Bearer " + userToken;
      res.status(200).send(json);
    } else {
      res.status(403).send("email exist");
    }
  });
});

// user sign up GET method
router.get("/signin", (req, res) => {
  res.sendFile(path.join(__dirname, "../../public/views", "signin.html"));
});

//
router.post("/signin", (req, res) => {
  let passwordCheckResult = {
    userName: null,
    validPassword: null,
    message: null,
    email: null
  };
  if (req.body.access_token) {
    passwordCheckResult = getFacebookData(req, req.body.access_token);
  } else {
    passwordCheckResult = checkEmailAndPassword(
      req,
      req.body.email,
      req.body.password
    );
  }
  passwordCheckResult.then((OkPacket) => {
    let userToken = null;
    if (OkPacket.validPassword === true) {
      if (OkPacket.message === "FBToken Response Data") {
        userToken = jwt.sign(
          {
            name: OkPacket.userName,
            email: OkPacket.email,
            provider: "facebook",
            picture: OkPacket.picture
          },
          process.env.ACCESS_TOKEN_SECRET,
          { expiresIn: process.env.USER_TOKEN_EXPIRE }
        );
      } else {
        userToken = jwt.sign(
          {
            name: OkPacket.userName,
            email: req.body.email,
            provider: "native",
            picture: null
          },
          process.env.ACCESS_TOKEN_SECRET,
          { expiresIn: process.env.USER_TOKEN_EXPIRE }
        );
      }
      const json = {
        data: {
          access_token: "Bearer " + userToken,
          access_expired: parseInt(process.env.USER_TOKEN_EXPIRE),
          user: {
            id: null,
            provider: null,
            name: OkPacket.userName,
            email: req.body.email,
            picture: null
          }
        }
      };
      if (OkPacket.message === "FBToken Response Data") {
        json.data.user.id = OkPacket.fbID;
        json.data.user.email = OkPacket.email;
        json.data.user.picture = OkPacket.picture;
        json.data.user.provider = "facebook";
      } else {
        json.data.user.id = OkPacket.insertId;
        json.data.user.email = req.body.email;
        json.data.user.provider = "native";
      }
      req.header.authorization = "Bearer " + userToken;
      res.status(200).send(json);
    } else if (OkPacket.message === "email not exist") {
      res.status(403).send("email not exist");
    } else if (OkPacket.email === null) {
      res.status(404).send("FBToken not valid");
    } else if (OkPacket.validPassword === false) {
      res.status(405).send("password incorrect");
    }
  });
});

// profile
router.get("/profile", (req, res) => {
  try {
    if (req.headers.authorization === undefined) {
      res.status(401).send("No Token");
      return;
    }
    if (Date.now() >= req.headers.authorization.exp * 1000) {
      res.status(403).send("Token Expired!");
    }
    const result = jwt.verify(
      req.headers.authorization.split(" ")[1],
      process.env.ACCESS_TOKEN_SECRET
    );
    const response = {
      data: {
        provider: result.provider,
        name: result.name,
        email: result.email,
        picture: result.picture
      }
    };
    res.status(200).send(response);
  } catch {
    res.status(404).send("Wrong Token!");
  }
});

module.exports = { router: router };
