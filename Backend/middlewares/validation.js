const Joi = require('@hapi/joi');

const registerValidation=(data)=>{
    const schema ={
        firstname: Joi.string().min(2).required(),
        lastname: Joi.string().min(2).required(),
        email: Joi.string().min(6).required().email(),
        password: Joi.string().min(6).required(),
        role: Joi.string().min(2).required(),
        phone: Joi.string().min(2).required(),
        image: Joi.string().min(2).required(),
        address: Joi.string().min(2).required(),
    };

    return Joi.validate(data, schema);
}

const loginValidation=(data)=>{
    const schema ={
        email: Joi.string().min(6).required().email(),
        password: Joi.string().min(6).required()
    };

    return Joi.validate(data, schema);
}

module.exports.registerValidation= registerValidation;
module.exports.loginValidation= loginValidation;

