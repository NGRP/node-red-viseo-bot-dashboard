const handlers = require('./statistics.handlers');

const BASE_ENDPOINT = '/api/statistics';


exports.getStatisticsRoute = {
    method: 'GET',
    path: `${BASE_ENDPOINT}`,
    config: {
        description: 'This endpoint sends back statistics.'
    },
    handler: handlers.getStatisticsHandler
};
