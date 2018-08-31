const Joi = require('joi');

const agent = Joi.string();
const stringId = Joi.string().regex(/[0-9]+/);
const userId = Joi.string();
const message = Joi.string();

exports.postHandoverParamsSchema = {
    active: Joi.string().valid('enable', 'disable').required()
};

exports.postHandoverPayloadSchema = {
    agent: agent.required(),
    userId: userId.required(),
    convId: stringId.required()
};

exports.postSendMessagePayloadSchema = {
    agent: agent.required(),
    userId: userId.required(),
    convId: stringId.required(),
    message: message.required()
};
