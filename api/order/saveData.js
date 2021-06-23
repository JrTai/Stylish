const express = require("express");
const router = express.Router();
const axios = require("axios");

// admin/product.html
router.post("/saveData", async (req, res) => {
  const { data } = await axios({
    url: "http://13.113.12.180:1234/api/1.0/order/data",
    method: "get"
  });
  let sql1 =
    "INSERT INTO orders (Order_ID, Shipping, Payment, Subtotal, Freight, Total, Name, Phone, Email, Address, Time, Paid, Rec_Trade_ID, User_ID) VALUES ";
  let sql2 =
    "INSERT INTO orderList (OrderList_ID, Orders_ID, Name, Price, Color_code, Size, Qty) VALUES ";
  let orderID = 1;
  let orderListID = 1;
  for (const order of data) {
    sql1 += `(${orderID}, "delivery", "credit_card", ${order.total - 60}, 60, ${
      order.total
    }, "Arthur", "0987654321", "arthur@gmail.com", "AppWorks", "Morning", 1, null, 3),`;
    for (const orderProduct of order.list) {
      sql2 += `(${orderListID}, ${orderID}, "product ${orderProduct.id}", ${
        orderProduct.price
      }, "${orderProduct.color.code.replace("#", "")}", "${
        orderProduct.size
      }", ${orderProduct.qty}),`;
      orderListID += 1;
    }
    orderID += 1;
  }
  sql1 = sql1.replace(/.$/, ";");
  sql2 = sql2.replace(/.$/, ";");
  req.app.get("pool").query(sql1, (err, orderListResult) => {
    if (err) throw err;
  });
  req.app.get("pool").query(sql2, (err, orderListResult) => {
    if (err) throw err;
  });
  res.send(`${orderID - 1} orders has been created into orders table!`);
});

module.exports = { router: router };
