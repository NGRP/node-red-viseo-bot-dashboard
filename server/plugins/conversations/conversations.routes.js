const handlers = require('./conversations.handlers');
const validators = require('./conversations.validators');

const BASE_ENDPOINT = '/api/conversations';

exports.getConversationListRoute = {
    method: 'GET',
    path: `${BASE_ENDPOINT}`,

    config: {
        description: 'This endpoint sends back the list of all conversations.'
    },

    handler: handlers.getConversationListHandler
};

exports.addMessageToConversationRoute = {
    method: 'POST',
    path: `${BASE_ENDPOINT}/{conversationId}`,

    config: {
        validate: { params: validators.addMessageToConversationParamsSchema },
        description: 'This endpoint adds a message from manager to the conversation specified in parameters.'
    },

    handler: handlers.addMessageToConversationHandler
};
