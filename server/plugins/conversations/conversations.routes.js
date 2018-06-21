const handlers = require('./conversations.handlers');

exports.getConversationListRoute = {
    method: 'GET',
    path: '/api/conversations',

    config: {
        description: 'This endpoint sends back the list of all conversations.'
    },

    handler: handlers.getConversationListHandler
};
