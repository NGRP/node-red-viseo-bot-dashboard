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

exports.getDatabase = () => { return database; };
