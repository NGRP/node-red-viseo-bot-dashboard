const handlers = require('./health-checks.handlers');

exports.getServerIsAliveRoute = {
    method: 'GET',
    path: '/api/hello',
    handler: handlers.getServerIsAliveHandler
};
