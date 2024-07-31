const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = process.env.PORT || 3000;
const app = express();

app.use(express.json());


//const DB = "mongodb://localhost:27017/bookhub"


mongoose
  .connect("mongodb://localhost:27017/bookhub_main2")
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.use(authRouter);

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});

