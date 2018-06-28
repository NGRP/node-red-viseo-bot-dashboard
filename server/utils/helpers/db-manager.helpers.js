const DECIMAL = 10;

const database = {
    conversations: []
};

exports.loadStaticDataIntoInMemoryDatabase = () => {
    return new Promise((resolve, reject) => {
        try {
            const mock = require('../../mocks/conversations.mocks.json');

            database.conversations.push(...mock);
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
