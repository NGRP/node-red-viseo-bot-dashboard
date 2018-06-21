const db = require('../../utils/helpers/db-manager.helpers').getDatabase();

exports.getConversationListHandler = (request, handler) => {
    return handler.response([ ...db.conversations ]);
};
