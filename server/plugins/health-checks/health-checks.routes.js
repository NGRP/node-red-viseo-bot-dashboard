const handlers = require('./health-checks.handlers');

exports.getServerIsAliveRoute = {
    method: 'GET',
    path: '/api/hello',
    config: {
        plugins: { lout: false }
    },
    handler: handlers.getServerIsAliveHandler
};

exports.getWebSocketRoute = {
    method: 'GET',
    path: '/api/ws',
    config: {
        plugins: { lout: false }
    },
    handler: (request) => {
      request.server.publish('/health', { ok: true });
      return  { ok: true };
    }
};
