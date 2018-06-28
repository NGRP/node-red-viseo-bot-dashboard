const Joi = require('joi');

const id = Joi.number().integer().min(0);

exports.conversationIdParamsSchema = {
    conversationId: id.required()
};
