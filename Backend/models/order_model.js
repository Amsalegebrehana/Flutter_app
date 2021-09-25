const mongoose = require("mongoose");

const schema = mongoose.Schema;

const orderSchema = new schema(
  {
    __v: { type: Number, select: false},
    status: {
      type: String,
      required: true,
    },

    progress: {
      type: String,
      required: false,
    },

    is_completed: {
      type: Boolean,
      required: true, 
    },

    order_created_date: {
      type: String,
      required: true,
    },

    order_completed_date: {
      type: String,
      required: false,
    },

    start_time: {
      type: Number,
      required: false,
    },

    saved_time: {
      type: Number,
      required: true,
    },

    unique_code: {
      type: Number,
      required: true,
    },

    seeker_id: {
      type: String,
      required: true,
      ref:"User",
    },

    provider_id: {
      type: String,
      required: true,
      ref:"User"
    },

    final_payment: {
      type: Number,
      required: false,
    },
  },
  { collection: "orders" }
);

module.exports = mongoose.model("Order", orderSchema);
