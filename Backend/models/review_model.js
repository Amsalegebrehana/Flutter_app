const mongoose = require("mongoose");

const schema = mongoose.Schema;

const reviewSchema = new schema(
  {
    __v: { type: Number, select: false},
    rating: {
      type: Number,
      required: true,
    },
    comment: {
      type: String,
      required: false,
    },

    order_id: {
      type: String,
      required: true,
    },
  },
  { collection: "review" }
);

module.exports = mongoose.model("Review", reviewSchema);
