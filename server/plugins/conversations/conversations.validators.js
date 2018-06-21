const Joi = require('joi');

const id = Joi.number().integer().min(0);

exports.addMessageToConversationParamsSchema = {
    conversationId: id.required()
};
