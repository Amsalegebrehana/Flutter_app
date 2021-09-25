const User= require("./models/user_model");
const Category= require("./models/category_model");
const Order= require("./models/order_model");
const Review= require("./models/review_model");

async function createUser(){
    const user= new User({
        firstname:"User",
        lastname:"One",
        password:"1234",
        email:"hey@gmail.com",
        role:"user",
        phone:"12345678",
        address:"heyStreet",

    });
    const result = await user.save();
    console.log(result);
};

async function createOrder(){
    const order= new Order({
        status:"pending",
        is_completed:"false",
        order_created_date:"14-08-2021",
        start_time: new Date(),
        saved_time:2,
        unique_code:12345,
        seeker_id:1,
        provider_id:3,
    });
    const result = await order.save();
    console.log(result);
};


async function createCategory(){
    const category= new Category({
        name:"Cleaning",
        image:"not yet",
        numOfProviders:3,
        description:"Cleaning service",
    });
    const result = await category.save();
    console.log(result);
};


async function createReview(){
    const review= new Review({
        rating:3,
        comment:"Good",
        order_id:1,
    });
    const result = await review.save();
    console.log(result);
};


let create= function(){
    createUser();
    createCategory();
    createOrder();
    createReview();
}

module.exports= create;