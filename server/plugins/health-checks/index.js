const routes = require('./health-checks.routes');

module.exports = exports = {
    name: 'Health Checks',
    register: async (server) => {
        server.route([
            routes.getServerIsAliveRoute
        ]);
    }
};
