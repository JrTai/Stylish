const express = require("express");
const router = express.Router();

// /create/fakeOrder API
// rrequest body example
// {"number": 1000}, create 1000 fake orders into orders table
router.post("/creatMockOrder", (req, res) => {
  const numberData = req.body.number;
  console.log(`create fake order ${numberData} data into orders table`);
  for (let i = 0; i < numberData; i += 1) {
    // orders insert
    const total = Math.floor(Math.random() * (1000 - 100 + 1) + 100);
    const userId = Math.floor(Math.random() * (5 - 1 + 1) + 1);
    const orderData = {
      Shipping: "delivery",
      Payment: "credit_card",
      Subtotal: total - 60,
      Freight: 60,
      Total: total,
      Name: "fake name",
      Phone: "fake phone",
      Email: "fake@gmail.com",
      Address: "fake street",
      Time: "Morning",
      Paid: 0,
      Rec_Trade_ID: null,
      User_ID: userId
    };
    const sql1 = "INSERT INTO orders SET ?;";
    req.app.get("pool").query(sql1, orderData, (err, results) => {
      if (err) throw err;
      const ordersID = results.insertId;
      // order list insert
      [1].forEach((product) => {
        const orderList = {
          Orders_ID: ordersID,
          Name: "fake item",
          Price: total,
          Color_code: "FFFFFF",
          Size: "S",
          Qty: 1
        };

        const sql2 = "INSERT INTO orderList SET ?;";
        req.app.get("pool").query(sql2, orderList, (err, orderListResult) => {
          if (err) throw err;
        });
      });
    });
  }
  res.send(`${numberData} orders has been created into orders table!`);
});

router.post("/creatMockOrderFaster", (req, res) => {
  const numberData = req.body.number;
  console.log(`create fake order ${numberData} data into orders table`);
  let sql1 = "INSERT INTO orders (Order_ID, Shipping, Payment, Subtotal, Freight, Total, Name, Phone, Email, Address, Time, Paid, Rec_Trade_ID, User_ID) VALUES ";
  let sql2 = "INSERT INTO orderList (OrderList_ID, Orders_ID, Name, Price, Color_code, Size, Qty) VALUES ";
  for (let i = 1; i <= numberData; i += 1) {
    // orders insert
    const total = Math.floor(Math.random() * (1000 - 100 + 1) + 100);
    const userId = Math.floor(Math.random() * (5 - 1 + 1) + 1);
    const subtotal = total - 60;
    sql1 += `(${i}, "delivery", "credit_card", ${subtotal}, 60, ${total}, "fake name", "fake phone", "fake@gmail.com", "fake street", "Morning", 0, null, ${userId}),`;
    sql2 += `(${i}, ${i}, "fake item", ${total}, "FFFFFF", "S", 1),`;
  }
  sql1 = sql1.replace(/.$/, ";");
  sql2 = sql2.replace(/.$/, ";");
  req.app.get("pool").query(sql1, (err, orderListResult) => {
    if (err) throw err;
  });
  req.app.get("pool").query(sql2, (err, orderListResult) => {
    if (err) throw err;
  });
  res.send(`${numberData} orders has been created into orders table!`);
});

router.post("/deleteOrder", (req, res) => {
  const sql1 = "DELETE FROM orders;";
  req.app.get("pool").query(sql1, (err, orderListResult) => {
    if (err) throw err;
  });

  const sql2 = "DELETE FROM orderList;";
  req.app.get("pool").query(sql2, (err, orderListResult) => {
    if (err) throw err;
  });

  res.send("orders and orderList table has been deleted all!");
});

module.exports = { router: router };
