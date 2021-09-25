const router = require("./routes/main");
const express = require("express");
const mongoose = require("mongoose");
const create = require("./init_db");
const dotenv = require("dotenv");

const DB_URI = process.env.MONGO_URI || "mongodb://localhost:27017/delalodb";
const app = express();

const cors=require("cors");
const corsOptions ={
   origin:'*', 
   credentials:true,            //access-control-allow-credentials:true
   optionSuccessStatus:200,
}
app.use(cors(corsOptions));

dotenv.config();

app.use(express.json());
app.use("/", router);
mongoose
  .connect(DB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: true,
  })
  .then(() =>
    app.listen(3000, () => {
      console.log("Server listening on port 3000");
    })
  )
  .catch((err) => console.log(`Error ${err}`));

//Run this function once using 'node app.js', it will create the db locally with
//all the collections. It will also add one document with sample data in each collection,
//which you can delete afterwards.
//create(); //DON'T FORGET TO COMMENT THIS OUT ONCE YOU'VE RUN IT
