const handlers = require('./users.handlers');
const validators = require('./users.validators');

const BASE_ENDPOINT = '/api/users';

exports.getUserListRoute = {
    method: 'GET',
    path: `${BASE_ENDPOINT}`,

    handler: handlers.getUserListHandler
};

exports.loginRoute = {
    method: 'POST',
    path: `${BASE_ENDPOINT}/login`,

    config: {
        validate: { payload: validators.loginPayloadSchema }
    },

    handler: handlers.loginHandler
};
