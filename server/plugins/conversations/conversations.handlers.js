const services = require('./conversations.services');

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

    // Send response message using websockets instead of HTTP response
    return handler.response(response).code(HTTP_CREATED);
};
