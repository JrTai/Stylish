const express = require("express");
const router = express.Router();

// admin/product.html
router.get("/payments", (req, res) => {
  // pass
  console.log("start payment");
  // const sql = "SELECT Total, User_ID FROM orders;";
  const sql = "SELECT User_ID, SUM(Total) FROM orders GROUP BY User_ID;";
  // const sum = {};
  req.app.get("pool").query(sql, (err, results) => {
    if (err) throw err;
    // for (const order of results) {
    //   if (order.User_ID in sum) {
    //     sum[order.User_ID] += order.Total;
    //   } else {
    //     sum[order.User_ID] = order.Total;
    //   }
    // }
    // console.log(sum);
    // const json = { data: [] };
    // for (const userId in sum) {
    //   const userPayment = {
    //     user_id: userId,
    //     total_payment: sum[userId]
    //   };
    //   json.data.push(userPayment);
    // }

    const json = { data: [] };
    for (const order of results) {
      const userPayment = {
        user_id: order.User_ID,
        total_payment: order["SUM(Total)"]
      };
      json.data.push(userPayment);
    }
    res.send(json);
  });
});

module.exports = { router: router };
