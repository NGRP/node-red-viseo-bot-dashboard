const { getDatabase, getLastConversationID } = require('../../utils/helpers/db-manager.helpers');
const conversationsTable = getDatabase().conversations;

exports.getConversationList = () => {
    return conversationsTable.map((conversation) => {
        const formatted = { ...conversation };
        delete formatted.messages;

        return { ...formatted };
    });
};

exports.getConversationByID = (conversationId) => {
    return conversationsTable.find((conversation) => { return conversation.id === conversationId; });
};

const createMessageObject = (message, id) => {
    return {
        ...message,
        date: message.date || new Date().toISOString(),
        conv_id: message.conv_id || id
    };
};

const createConversationObject = (newMessage) => {
    return {
        id: getLastConversationID(),
        last_msg_date: newMessage.date,
        user_id: newMessage.user_id,
        user_name: newMessage.user_name,
        msg_status: newMessage.msg_status,
        handover: null,
        messages: [
            { ...newMessage }
        ]
    };
};


const createBroadcastHandoverUpdate = (conversation) => {
    return {
        type: 'handoverUpdate',
        payload: conversation
    };
};
exports.broadcastHandoverUpdate = (server, conversation) => {
    server.broadcast(createBroadcastHandoverUpdate(conversation));
};


const createBroadcastNewMessage = (newMessage) => {
    return {
        type: 'newMessage',
        payload: newMessage
    };
};

const handleNewMessage = (conversation, message, server) => {
    conversation.messages.push(message);

    switch (message.msg_type) {
        case 'MSG_HANDLER_STATE':
            conversation.handover = conversation.handover ? null : '1';
            this.broadcastHandoverUpdate(server, conversation);
            break;
    }

    this.broadcastNewMessage(server, message);
};

exports.broadcastNewMessage = (server, message) => {
    server.broadcast(createBroadcastNewMessage(message));
};

exports.addMessageToConversation = async (conversationId, message, server) => {
    return new Promise(async (resolve, reject) => {
        try {
            const newMessage = createMessageObject(message);

            const matchingConversation = conversationsTable.find((conversation) => { return conversation.id === conversationId; });

            if (!matchingConversation) {
                return reject(new Error('No conversation found'));
            } else {
                handleNewMessage(matchingConversation, newMessage, server);
            }

            return resolve(newMessage);
        } catch (error) {
            return reject(error);
        }
    });
};

exports.addNewConversation = (message) => {
    return new Promise(async (resolve, reject) => {
        try {
            const newConversation = createConversationObject(createMessageObject(message));
            conversationsTable.push(newConversation);

            return resolve(newConversation);
        } catch (error) {
            return reject(error);
        }
    });
};

