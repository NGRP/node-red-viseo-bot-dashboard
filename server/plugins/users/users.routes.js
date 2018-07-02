const handlers = require('./users.handlers');

const BASE_ENDPOINT = '/api/users';

exports.getUserListRoute = {
    method: 'GET',
    path: `${BASE_ENDPOINT}`,

    handler: handlers.getUserListHandler
};
