const { getDatabase, getLastMessageID } = require('../../utils/helpers/db-manager.helpers');
const conversationsTable = getDatabase().conversations;

exports.addMessageToConversation = async (conversationId, message) => {
    return new Promise(async (resolve, reject) => {
        try {
            const newMessage = {
                id: await getLastMessageID(conversationId) + 1,
                ...message
            };

            const matchingConversation = conversationsTable.find((conversation) => { return conversation.id === conversationId; });
            matchingConversation.messages.push(newMessage);

            return resolve(newMessage);
        } catch (error) {
            return reject(error);
        }
    });
};
