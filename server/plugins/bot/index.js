const routes = require('./bot.routes');

module.exports = exports = {
    name: 'Bot',
    register: async (server) => {
        server.route([
            routes.postHandoverRoute,
            routes.postSendMessageRoute
        ]);
    }
};
