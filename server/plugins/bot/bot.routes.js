const validators = require('./bot.validators');
const handlers = require('./bot.handlers');

exports.postHandoverRoute = {
    method: 'POST',
    path: '/api/bot/handover/{active}',

    config: {
        validate: {
            params: validators.postHandoverParamsSchema,
            payload: validators.postHandoverPayloadSchema
        }
    },

    handler: handlers.handoverBotFrameworkHandler
};

exports.postSendMessageRoute = {
    method: 'POST',
    path: '/api/bot/message',

    config: {
        validate: { payload: validators.postSendMessagePayloadSchema }
    },

    handler: handlers.sendMessageToBotFrameworkHandler
};
