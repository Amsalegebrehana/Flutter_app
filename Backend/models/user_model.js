const mongoose = require("mongoose");
const mongoose_fuzzy_searching = require("custom-mongoose-fuzzy-searching");
const schema = mongoose.Schema;
const userSchema = new schema(
  {
    __v:{
      type: String,
      select: false
    },
    firstname: {
      type: String,
      required: true,
    },
    lastname: {
      type: String,
      required: true,
    },
    password: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
    role: {
      type: String,
      required: true,
    },
    phone: {
      type: String,
      required: true,
    },
    image: {
      type: String,
      required: false,
    },
    address: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: false,
    },
    category: {
      type: String,
      required: false,
    },
    jobs_done: {
      type: Number,
      required: false,
    },
    per_hour_wage: {
      type: Number,
      required: false,
    },
    recommendation: {
      type: String,
      required: false,
    },
    average_rating: {
      type: Number,
      required: false,
    },
    __v: {
      type: String,
      select: false,
    },
  },
  { collection: "user" }
);

userSchema.plugin(mongoose_fuzzy_searching, {
  fields: ["firstname", "lastname", "address"],
});
module.exports = mongoose.model("user", userSchema);
