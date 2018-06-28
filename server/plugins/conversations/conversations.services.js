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

exports.addMessageToConversation = async (conversationId, message) => {
    return new Promise(async (resolve, reject) => {
        try {
            const newMessage = createMessageObject(message);

            const matchingConversation = conversationsTable.find((conversation) => { return conversation.id === conversationId; });

            if (!matchingConversation) {
                conversationsTable.push(createConversationObject(newMessage));
            } else {
                matchingConversation.messages.push(newMessage);
            }

            return resolve(newMessage);
        } catch (error) {
            return reject(error);
        }
    });
};
