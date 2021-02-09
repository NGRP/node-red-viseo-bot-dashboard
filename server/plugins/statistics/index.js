const routes = require('./statistics.routes');

module.exports = exports = {
    name: 'Statistics',
    register: async (server) => {
        server.route([
            routes.getStatisticsRoute
        ]);
    }
};
