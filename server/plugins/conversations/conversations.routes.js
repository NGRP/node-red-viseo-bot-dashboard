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
        validate: {
            params: validators.conversationIdParamsSchema,
            payload: validators.messagePayloadSchema
        },
        description: 'This endpoint adds a message from manager to the conversation specified in parameters.'
    },

    handler: handlers.addMessageToConversationHandler
};

exports.handoverConversationRoute = {
    method: 'PATCH',
    path: `${BASE_ENDPOINT}/{conversationId}`,

    config: {
        validate: {
            params: validators.conversationIdParamsSchema,
            payload: validators.handoverPayloadSchema
        },
        description: 'This endpoint is called when a dashboard user whishes to ' +
        'take control or release the conversation'
    },

    handler: handlers.handoverConversationHandler
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

/* exports.addNewConversationRoute = {
    method: 'POST',
    path: `${BASE_ENDPOINT}`,

    config: {
        validate: { payload: validators.conversationPayloadSchema },
        description: 'This endpoint adds a new conversation with a message.'
    },

    handler: handlers.addNewConversationHandler
};*/
