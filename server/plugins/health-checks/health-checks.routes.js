const handlers = require('./health-checks.handlers');

exports.getServerIsAliveRoute = {
    method: 'GET',
    path: '/api/hello',
    config: {
        plugins: { lout: false }
    },
    handler: handlers.getServerIsAliveHandler
};
