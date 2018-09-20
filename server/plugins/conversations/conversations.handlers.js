const services = require('./conversations.services');

const { HTTP_CREATED } = require('../../utils/constants/http.constants');

exports.getConversationListHandler = (request, handler) => {
    return handler.response(services.getConversationList());
};

exports.handoverConversationHandler = (request, handler) => {
    const conversationId = request.params.conversationId.toString();
    const conversation = services.getConversationByID(conversationId);
    conversation.handover = request.payload.handover;

    services.broadcastHandoverUpdate(request.server, conversation);
    return handler.response(conversation);
};

exports.getConversationListByIDHandler = (request, handler) => {
    const conversationId = request.params.conversationId.toString();
    return handler.response(services.getConversationByID(conversationId));
};

exports.addMessageToConversationHandler = async (request, handler) => {
    const response = await services.addMessageToConversation(request.params.conversationId.toString(), request.payload);
    services.broadcastNewMessage(request.server, response);

    // Send response message using websockets instead of HTTP response
    return handler.response(response).code(HTTP_CREATED);
};
