const express = require("express");
const mysql = require("mysql");
const path = require("path");

const app = express();

// set trust proxy to get client ip
app.set("trust proxy", true);

// set product, variant, campaign admin create router
const routesAdminCreate = require("./api/product/admin_creat").router;
app.use(routesAdminCreate);

// set product api router
const apiRoutesProduct = require("./api/product/product_api").router;
app.use("/api/1.0/products", apiRoutesProduct);

// set user api router
const apiRoutesUser = require("./api/user/user_api").router;
app.use("/api/1.0/user", apiRoutesUser);

// set campaigns api router
const apiRoutesCampaign = require("./api/marketing/campaign_api").router;
app.use("/api/1.0/marketing", apiRoutesCampaign);

// set order api router
const apiRoutesCheckout = require("./api/order/checkout_api").router;
app.use("/api/1.0/order", apiRoutesCheckout);

// set get payment api router
const apiRoutesGetPayment = require("./api/order/getPayment").router;
app.use("/api/1.0/order", apiRoutesGetPayment);

// set save midterm data to DB api router
const apiSaveDataToDB = require("./api/order/saveData").router;
app.use("/api/1.0/order", apiSaveDataToDB);

// set dashboard data api router
const apiDashboardData = require("./api/order/getDashboardData").router;
app.use("/api/1.0/order", apiDashboardData);

// set admin api router
const apiRoutesAdmin = require("./api/admin/admin").router;
app.use("/admin", apiRoutesAdmin);

// set admin api router
const apiCreateOrder = require("./api/createOrder/createOrder").router;
app.use("/data", apiCreateOrder);

app.use(express.static("public"));

// set .env
require("dotenv").config();

// create connection
function DbConnection () {
  const pool = mysql.createPool({
    host: process.env.host,
    user: process.env.user,
    password: process.env.password,
    database: process.env.database
  });

  // pool.connect((err) => {
  //   if (err) throw err;
  //   console.log("MySQL Database Connected!");
  // });
  return pool;
}

app.set("pool", new DbConnection());

// root route
app.get(["/", "/index.html"], (req, res) => {
  res.sendFile(path.join(__dirname, "/public/views/index.html"));
});

// product detail route
app.get("/product.html", (req, res) => {
  res.sendFile(path.join(__dirname, "/public/views/detail.html"));
});

// cart route
app.get("/cart.html", (req, res) => {
  res.sendFile(path.join(__dirname, "/public/views/cart.html"));
});

// thank you route
app.get("/thankyou.html", (req, res) => {
  res.sendFile(path.join(__dirname, "/public/views/thankyou.html"));
});

// profile route
app.get("/profile.html", (req, res) => {
  res.sendFile(path.join(__dirname, "/public/views/profile.html"));
});

// dashboard route
app.get("/admin/dashboard.html", (req, res) => {
  res.sendFile(path.join(__dirname, "/public/views/dashboard.html"));
});

const httpServer = require("http").createServer(app);
const options = {
  /* ... */
};
const io = require("socket.io")(httpServer, options);

io.on("connection", (socket) => {
  console.log("socket.io start connect");
  socket.on("order", (msg) => {
    console.log(msg);
    socket.join("room1");
    socket.to("room2").emit("refresh", "refresh value");
  });

  socket.on("dashboard", (msg) => {
    console.log(msg);
    socket.join("room2");
  });
});

// httpServer.listen is also fine
httpServer.listen(3000, () => {
  console.log("The application is running on localhose:3000");
});
