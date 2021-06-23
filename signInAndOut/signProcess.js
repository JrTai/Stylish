const bcrypt = require("bcrypt");
const axios = require("axios");

const queryDB = require(".././api/product/product_api").queryDB;

function checkAdmin (req, email) {
  return new Promise((resolve) => {
    const sql = `SELECT * FROM user WHERE Email = '${email}';`;
    req.app.get("pool").query(sql, (err, result) => {
      if (err) throw err;
      resolve(result);
    });
  });
}

function insertNewUser (req, name, email, hashedPassword) {
  return new Promise((resolve) => {
    const user = {
      Name: name,
      Email: email,
      Password: hashedPassword
    };
    const sql = "INSERT INTO user SET ?;";
    req.app.get("pool").query(sql, user, (err, result) => {
      if (err) throw err;
      resolve(result);
    });
  });
}

async function checkEmailAndInsert (req, name, email, password) {
  const userTableContentLength = await queryDB(
    req,
    "user",
    "Email",
    email,
    "length"
  );

  if (userTableContentLength) {
    // email exist
    return false;
  } else {
    // insert new user
    const salt = await bcrypt.genSalt();
    const hashedPassword = await bcrypt.hash(password, salt);
    const insertResult = await insertNewUser(req, name, email, hashedPassword);
    return insertResult;
  }
}

async function checkEmailAndPassword (req, email, password) {
  const userTableContent = await queryDB(
    req,
    "user",
    "Email",
    email,
    "tableContent"
  );
  const result = {
    userName: null,
    validPassword: null,
    message: null
  };

  if (userTableContent.length) {
    const validPassword = await bcrypt.compare(
      password,
      userTableContent[0].Password
    );
    result.userName = userTableContent[0].Name;
    result.validPassword = validPassword;
    return result;
  } else {
    result.message = "email not exist";
    return result;
  }
}

async function getFacebookData (req, FBtoken) {
  const passwordCheckResult = {
    fbID: null,
    userName: null,
    validPassword: null,
    message: "FBToken Response Data",
    email: null,
    picture: null
  };
  try {
    const { data } = await axios({
      url: "https://graph.facebook.com/me",
      method: "get",
      params: {
        fields: ["id", "email", "name", "picture"].join(","),
        access_token: FBtoken
      }
    });

    const userTableContentLength = await queryDB(
      req,
      "user",
      "Email",
      data.email,
      "length"
    );
    if (userTableContentLength === 0) {
      await insertNewUser(req, data.name, data.email, null);
    }

    passwordCheckResult.fbID = data.id;
    passwordCheckResult.userName = data.name;
    passwordCheckResult.validPassword = true;
    passwordCheckResult.email = data.email;
    passwordCheckResult.picture = data.picture.data.url;
  } catch {
    passwordCheckResult.validPassword = false;
  }
  return passwordCheckResult;
}

module.exports = {
  checkEmailAndInsert: checkEmailAndInsert,
  checkEmailAndPassword: checkEmailAndPassword,
  getFacebookData: getFacebookData,
  checkAdmin: checkAdmin
};
