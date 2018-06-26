const validators = require('./bot.validators');
const handlers = require('./bot.handlers');

exports.postHandoverRoute = {
    method: 'POST',
    path: '/api/bot/handover/{active}',

    config: {
        validate: {
            params: validators.postHandoverParamsSchema,
            payload: validators.postHandoverPayloadSchema
        },
        description: 'This endpoint is called when a dashboard user whishes to ' +
        'take control from the bot or handover control to the bot.'
    },

    handler: handlers.handoverBotFrameworkHandler
};

exports.postSendMessageRoute = {
    method: 'POST',
    path: '/api/bot/message',

    config: {
        validate: { payload: validators.postSendMessagePayloadSchema },
        description: 'This endpoints is called when a dashboard user send a message to a conversation he took control.'
    },

    handler: handlers.sendMessageToBotFrameworkHandler
};
