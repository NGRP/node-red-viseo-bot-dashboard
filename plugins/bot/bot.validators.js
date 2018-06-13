const Joi = require('joi');

const agent = Joi.string().required();
const userId = Joi.string().required();
const message = Joi.string().required();

exports.postHandoverParamsSchema = {
    active: Joi.string().valid('enable', 'disable').required()
};

exports.postHandoverPayloadSchema = {
    agent,
    userId
};

exports.postSendMessagePayloadSchema = {
    agent,
    userId,
    message
};
