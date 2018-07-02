const services = require('./users.services');

exports.getUserListHandler = async (request, handler) => {
    return handler.response(await services.getUserList());
};
