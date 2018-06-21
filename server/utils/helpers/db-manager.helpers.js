const Boom = require('boom');

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

exports.getLastMessageID = (id) => {
    return new Promise((resolve, reject) => {
        try {
            const match = database.conversations.find((conversation) => { return conversation.id === id; });

            if (!match) {
                const error = Boom.notFound('The conversation does not exists');
                return reject(error);
            }

            const list = [
                ...match.messages
            ];

            return resolve(list.reduce((previous, current) => { return (previous.id > current.id) ? previous.id : current.id; }));
        } catch (err) {
            return reject(err);
        }
    });
};

exports.getDatabase = () => { return database; };
