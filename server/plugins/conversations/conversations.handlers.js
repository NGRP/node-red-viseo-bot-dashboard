const services = require('./conversations.services');
const websockets = require('../../utils/helpers/websockets.helpers');

const { HTTP_CREATED } = require('../../utils/constants/http.constants');

exports.getConversationListHandler = (request, handler) => {
    return handler.response(services.getConversationList());
};

exports.getConversationListByIDHandler = (request, handler) => {
    const conversationId = request.params.conversationId.toString();
    return handler.response(services.getConversationByID(conversationId));
};

exports.addMessageToConversationHandler = async (request, handler) => {

    const response = await services.addMessageToConversation(request.params.conversationId.toString(), request.payload);
    services.broadcastNewMessage(request.server, response);

    await websockets.publishNewMessage(request.server, id, response);
    return handler.response(response).code(HTTP_CREATED);
};

exports.addNewConversationHandler = async (request, handler) => {
    const response = await services.addNewConversation(request.payload);

    await websockets.publishNewConversation(request.server, response);
    return handler.response(response).code(HTTP_CREATED);
};
