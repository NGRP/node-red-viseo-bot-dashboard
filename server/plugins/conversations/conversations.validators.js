const Joi = require('joi');

const MINIMAL_STATUS = 0;
const MAXIMAL_STATUS = 9;

const id = Joi.number().integer().min(0);
const stringId = Joi.string().regex(/[0-9]+/);
const username = Joi.string();
const date = Joi.date().iso();
const status = Joi.number().min(MINIMAL_STATUS).max(MAXIMAL_STATUS);
const userTalking = Joi.string().valid([ 'BOT', 'USER', 'AGENT' ]);
const type = Joi.string().valid([ 'START_CONV', 'END_CONV', 'MSG_TEXT', 'MSG_QUICK', 'MSG_HANDLER_STATE' ]);
const content = Joi.string();

exports.conversationIdParamsSchema = {
    conversationId: id.required()
};

exports.handoverPayloadSchema = {
    handover: stringId.required().allow(null),
};

exports.messagePayloadSchema = {
    date: date.required(),
    conv_id: stringId.required(),
    user_id: stringId.required(),
    user_name: username.required(),
    msg_status: status.required(),
    user_talking: userTalking.required(),
    msg_type: type.required(),
    msg_content: content.required()
};
exports.conversationPayloadSchema = {
    date: date.required(),
    user_id: stringId.required(),
    user_name: username.required(),
    msg_status: status.required(),
    user_talking: userTalking.required(),
    msg_type: type.required(),
    msg_content: content.required()
};
