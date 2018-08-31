const DECIMAL = 10;

const database = {
    conversations: [],
    users: []
};

exports.loadStaticDataIntoInMemoryDatabase = () => {
    return new Promise((resolve, reject) => {
        try {
            const conversationsMock = require('../../mocks/conversations.mocks.json');
            const usersMock = require('../../mocks/users.mocks.json');

            database.conversations.push(...conversationsMock);
            database.users.push(...usersMock);
            resolve();
        } catch (err) {
            reject(err);
        }
    });
};

exports.getLastConversationID = () => {
    return (database.conversations.reduce((p, c) => {
        return (parseInt(p.id, DECIMAL) > parseInt(c.id, DECIMAL)) ? parseInt(p.id, DECIMAL) : parseInt(c.id, DECIMAL);
    }) + 1).toString();
};

exports.getDatabase = () => { return database; };
