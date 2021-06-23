const express = require("express");
const router = express.Router();
const bodyParser = require("body-parser");
const https = require("https");
const jwt = require("jsonwebtoken");

router.use(bodyParser.json());
router.use(bodyParser.text());
router.use(bodyParser.urlencoded({ extended: false }));

router.post("/checkout", async (req, res) => {
  let userId = null;
  if (req.headers.authorization === undefined) {
    res.status(401).send("No Token");
    return;
  } else {
    let user;
    try {
      user = jwt.verify(
        req.headers.authorization.split(" ")[1],
        process.env.ACCESS_TOKEN_SECRET
      );

      userId = await new Promise((resolve) => {
        const getUserId = `SELECT User_ID FROM user WHERE Email = '${user.email}';`;
        req.app.get("pool").query(getUserId, (err, results) => {
          if (err) throw err;
          resolve(results[0].User_ID);
        });
      });
    } catch (err) {
      res.status(401).send("token expired");
      return;
    }
  }

  const partnerKey = process.env.TAPPAY_PARTNER_KEY;
  const merchantId = "AppWorksSchool_CTBC";

  const orderData = {
    Shipping: req.body.order.shipping,
    Payment: req.body.order.payment,
    Subtotal: req.body.order.subtotal,
    Freight: req.body.order.freight,
    Total: req.body.order.total,
    Name: req.body.order.recipient.name,
    Phone: req.body.order.recipient.phone,
    Email: req.body.order.recipient.email,
    Address: req.body.order.recipient.address,
    Time: req.body.order.recipient.time,
    Paid: false,
    Rec_Trade_ID: null,
    User_ID: userId
  };

  const sql1 = "INSERT INTO orders SET ?;";
  req.app.get("pool").query(sql1, orderData, (err, ordersResult) => {
    if (err) throw err;
    const ordersID = ordersResult.insertId;
    req.body.order.list.forEach((product) => {
      const orderList = {
        Orders_ID: ordersID,
        Name: product.name,
        Price: product.price,
        Color_code: product.color.code,
        Size: product.size,
        Qty: product.qty
      };

      const sql2 = "INSERT INTO orderList SET ?;";
      req.app.get("pool").query(sql2, orderList, (err, orderListResult) => {
        if (err) throw err;
      });
    });

    const paymentInfo = {
      prime: req.body.prime,
      partner_key: partnerKey,
      merchant_id: merchantId,
      amount: req.body.order.total,
      currency: "TWD",
      details: `Total Item: ${req.body.order.list.length}`,
      cardholder: {
        phone_number: req.body.order.recipient.phone,
        name: req.body.order.recipient.name,
        email: req.body.order.recipient.email
      },
      remember: false
    };

    const postOptions = {
      host: "sandbox.tappaysdk.com",
      port: 443,
      path: "/tpc/payment/pay-by-prime",
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-api-key": partnerKey
      }
    };

    const postReq = https.request(postOptions, function (response) {
      let paymentResult;
      response.setEncoding("utf8");
      response.on("data", function (body) {
        try {
          paymentResult = JSON.parse(body);
        } catch {
          paymentResult = { msg: "fail" };
        }
        if (paymentResult.msg === "Success") {
          const sql3 = `UPDATE orders SET Paid = true, Rec_Trade_ID = '${paymentResult.rec_trade_id}' WHERE Order_ID = ${ordersID};`;
          req.app
            .get("pool")
            .query(sql3, ordersID, (err, updateOrdersResult) => {
              if (err) throw err;
            });
        }
        const tappayResult = {
          result: paymentResult,
          orderId: `${ordersID}`
        };
        // return res.send(tappayResult);
        res.send(tappayResult);
      });
    });

    // payment fail will has problem
    console.log(postReq);
    postReq.write(JSON.stringify(paymentInfo));
    postReq.end();
  });
});

module.exports = { router: router };
