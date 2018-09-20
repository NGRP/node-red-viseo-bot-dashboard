const routes = require('./conversations.routes');

module.exports = exports = {
    name: 'Conversations',
    register: async (server) => {
        server.route([
            routes.getConversationListRoute,
            routes.handoverConversationRoute,
            routes.addMessageToConversationRoute,
            routes.getConversationByIDRoute
            //  routes.addNewConversationRoute
        ]);
    }
};
