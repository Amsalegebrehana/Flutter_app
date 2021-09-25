const mongoose = require("mongoose");
const mongoose_fuzzy_searching = require("custom-mongoose-fuzzy-searching");
const { string } = require("@hapi/joi");
const schema = mongoose.Schema;

const categorySchema = new schema(
  {
    __v: { type: Number, select: false},
    name: {
      type: String,
      required: true,
      unique: true 
    },
    image: {
      type: String,
      required: true,
    },
    numOfProviders: {
      type: Number,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
  },
  { collection: "category" }
);

categorySchema.plugin(mongoose_fuzzy_searching,{fields:['name']});
// categorySchema.index({name:'text'});
module.exports = mongoose.model("category", categorySchema);
