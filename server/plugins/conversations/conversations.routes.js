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
        validate: { params: validators.conversationIdParamsSchema },
        // TODO: Payload validator to be defined
        description: 'This endpoint adds a message from manager to the conversation specified in parameters.'
    },

    handler: handlers.addMessageToConversationHandler
};

exports.getConversationByIDRoute = {
    method: 'GET',
    path: `${BASE_ENDPOINT}/{conversationId}`,

    config: {
        validate: { params: validators.conversationIdParamsSchema },
        description: 'This endpoint sends back the full conversation specified by ID.'
    },

    handler: handlers.getConversationListByIDHandler
};
