const Joi = require('joi');

const username = Joi.string();
const password = Joi.string();

exports.loginPayloadSchema = {
    username: username.required(),
    password: password.required()
};
