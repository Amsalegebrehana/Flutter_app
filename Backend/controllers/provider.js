const models = require("../models/user_model");
const categoryModels = require("../models/category_model");
const orderModel = require("../models/order_model");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

const postProvider = async (req, res) => {
  console.log("this got here");
  const emailExist = await models.findOne({ email: req.body.email });
  if (emailExist) {
    return res.status(400).send("Email already exists");
  }

  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(req.body.password, salt);

  const providersList = new models({
    firstname: req.body.firstname,
    lastname: req.body.lastname,
    password: hashedPassword,
    email: req.body.email,
    role: req.body.role,
    phone: req.body.phone,
    image: req.body.image,
    address: req.body.address,
    description: req.body.description,
    category: req.body.category,
    jobs_done: req.body.jobs_done,
    per_hour_wage: req.body.per_hour_wage,
    recommendation: req.body.recommendation,
    average_rating: req.body.average_rating,
  });

  providersList
    .save()
    .then((result) => {
      const token = jwt.sign(
        {
          _id: result._id,
        },
        process.env.TOKEN_SECRET
      );
      const postResult = {
        id: result._id,
        role: result.role,
        token: token,
      };
      res.status(200).send(postResult);
    })
    .catch((err) => {
      console.log(err);
    });
};

const getProvider = (req, res) => {
  models
    .find()
    .then((result) => {
      if (result.length == 0) {
        res.send({ message: "No providers found" });
      } else {
        res.send(result);
      }
    })
    .catch((err) => {
      console.log(err);
    });
};

const getProviderById = (req, res) => {
  models
    .findById(req.params.id)
    .then((result) => {
      if (!result) {
        res.send({ message: "No provider with this Id found" });
      } else {
        res.send(result);
      }
    })
    .catch((err) => {
      res.send(err);
      console.log(err);
    });
};

const updateProviderById = (req, res) => {
  if (!req.body) {
    return res.status(400).send({
      message: "Data to update can not be empty!",
    });
  }
  models
    .findByIdAndUpdate(
      {
        _id: req.params.id,
      },

      req.body,
      { new: true }
    )

    .then((provider) => {
      if (!provider) {
        res.status(404).send({
          message: `Couldn't update provider with id ${req.params.id}`,
        });
      } else {
        res.status(201).send(provider);
      }
    })
    .catch((err) => {
      res.status(500).send({
        message: `Error updating ${req.params.id}`,
      });
    });
};
const searchProviders = async function (req, res) {
  const keyword = req.body.keyword;
  const perHourWage = req.body.per_hour_wage;
  let rating = req.body.average_rating;
  if (rating && perHourWage) {
    const providers = await models.fuzzySearch(keyword).find(
      {
        per_hour_wage: perHourWage,
        average_rating: rating,
      },
      function (err, result) {
        if (err) {
          return res.status(404).json({ message: err });
        } else {
          return res.status(200).json({ result });
        }
      }
    );
  } else if (perHourWage) {
    const providers = await models.fuzzySearch(keyword).find(
      {
        per_hour_wage: perHourWage,
      },
      function (err, result) {
        if (err) {
          return res.status(404).json({ message: err });
        } else {
          return res.status(200).json({ result });
        }
      }
    );
  } else if (rating) {
    const providers = await models.fuzzySearch(keyword).find(
      {
        average_rating: rating,
      },
      function (err, result) {
        if (err) {
          return res.status(404).json({ message: err });
        } else {
          return res.status(200).json({ result });
        }
      }
    );
  } else {
    const providers = await models.fuzzySearch(keyword, function (err, result) {
      if (err) {
        return res.status(404).json({ message: err });
      } else {
        return res.status(200).json({ result });
      }
    });
  }
};

const getTopProviders = (req, res) => {
  models
    .find()
    .where("average_rating")
    .gte(3)
    .then((result) => {
      if (result.length == 0) {
        res.send({ message: "No top providers found" });
      } else {
        res.send(result);
      }
    })
    .catch((err) => {
      res.send({ message: err.message });
    });
};

const getProvidersByCategory = (req, res) => {
  const category= req.params.category;
  models
    .find({category:category,role:"provider"})
    .then((result) => {
  
      if (result.length == 0) {
        res.send({ message: "No providers within this category" });
      } else {
        res.status(200).json(result);
      }
    })
    .catch((err) => {
      res.send({ message: err.message });
    });
};

const getTopProvidersByCategory = (req, res) => {
  models
    .find()
    .where({ category: req.params.category_name })
    .where("average_rating")
    .gte(3)
    .then((result) => {
      if (result.length == 0) {
        res.send({ message: "No top providers within this category" });
      } else {
        res.send(result);
      }
    });
};

module.exports = {
  postProvider,
  getProvider,
  searchProviders,
  getProviderById,
  updateProviderById,
  getTopProviders,
  getProvidersByCategory,
  getTopProvidersByCategory,
};
