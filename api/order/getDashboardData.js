const express = require("express");
const router = express.Router();
const ntc = require("ntcjs");

router.get("/dashboard/total", (req, res) => {
  const sql = "SELECT SUM(Total) FROM orders;";
  req.app.get("pool").query(sql, (err, results) => {
    if (err) throw err;
    const json = { total: results[0]["SUM(Total)"] };
    res.send(json);
  });
});

router.get("/dashboard/pieChart", async (req, res) => {
  const sql1 = "SELECT * FROM colors;";
  req.app.get("pool").query(sql1, (err, results) => {
    if (err) throw err;
    const colorMap = {};
    for (const color of results) {
      colorMap[color.Color_code] = color.Color_name;
    }

    // !!!
    // colorMap might has a problem, color input manually vs admin has slightly different format
    // console.log(colorMap);

    const sql2 =
      "SELECT Color_code, SUM(Qty) FROM orderList GROUP BY Color_code;";
    req.app.get("pool").query(sql2, (err, results) => {
      if (err) throw err;
      let total = 0;
      const json = { sum: 0, data: [] };
      for (const item of results) {
        total += item["SUM(Qty)"];
        const colorSold = {
          color: ntc.name(item.Color_code)[1], // use ntc.name instead of colorMap
          colorCode: item.Color_code,
          sold: item["SUM(Qty)"]
        };
        json.data.push(colorSold);
      }
      json.sum = total;
      res.send(json);
    });
  });
});

router.get("/dashboard/histogramCountBySQL", (req, res) => {
  // sql range example
  // let sql = `select sum(case when stylish.orderList.Price <= 500 then 1 else 0 end) as range1,
  // sum(case when stylish.orderList.Price > 750 and stylish.orderList.Price <= 1000 then 1 else 0 end) as range2,
  // sum(case when stylish.orderList.Price > 1000 then 1 else 0 end) as range3
  // from stylish.orderList;`;

  // count by SQL
  let sql =
    "select sum(case when stylish.orderList.Price <= 500 then 1 else 0 end) as range1,";
  let rangeIdx = 2;
  for (let price = 500; price < 2000; price += 10) {
    const range = `sum(case when stylish.orderList.Price > ${price} and stylish.orderList.Price <= ${
      price + 10
    } then 1 else 0 end) as range${rangeIdx},`;
    sql += range;
    rangeIdx += 1;
  }
  sql += `sum(case when stylish.orderList.Price > 2000 then 1 else 0 end) as range${rangeIdx} from stylish.orderList`;
  req.app.get("pool").query(sql, (err, results) => {
    if (err) throw err;
    const json = { data: [] };
    for (let idx = 1; idx <= Object.keys(results[0]).length; idx += 1) {
      json.data.push(results[0][`range${idx}`]);
    }
    res.send(json);
  });
});

router.get("/dashboard/histogram", (req, res) => {
  const sql = "SELECT Price, Qty FROM orderList;";
  req.app.get("pool").query(sql, (err, results) => {
    if (err) throw err;
    const json = { data: [] };
    for (const order of results) {
      for (let i = 1; i <= order.Qty; i += 1) {
        json.data.push(order.Price);
      }
    }
    res.send(json);
  });
});

router.get("/dashboard/barChart", (req, res) => {
  const sql1 =
    "SELECT SUM(Qty), Name FROM orderList GROUP BY Name ORDER BY SUM(Qty) DESC;";
  req.app.get("pool").query(sql1, (err, results) => {
    if (err) throw err;
    const top5Product = [];
    for (const order of results) {
      const productName = order.Name.trim().replace(" ", "_");
      top5Product.push(productName);
      if (top5Product.length === 5) {
        break;
      }
    }

    const sql2 =
      "SELECT SUM(Qty), Name, Size FROM orderList GROUP BY Name, Size ORDER BY SUM(Qty) DESC;";
    req.app.get("pool").query(sql2, (err, results) => {
      if (err) throw err;
      //   console.log(results);
      const json = { data: {} };
      json.order = top5Product;
      for (const order of results) {
        // json.data.push(order.Price);
        const orderProductName = order.Name.trim().replace(" ", "_");

        if (top5Product.includes(orderProductName)) {
          if (orderProductName in json.data) {
            if (order.Size in json.data[orderProductName]) {
              json.data[orderProductName][order.Size] += order["SUM(Qty)"];
            } else {
              json.data[orderProductName][order.Size] = order["SUM(Qty)"];
            }
          } else {
            json.data[orderProductName] = {};
            json.data[orderProductName][order.Size] = order["SUM(Qty)"];
          }
        }
      }
      res.send(json);
    });
  });
});

module.exports = { router: router };
