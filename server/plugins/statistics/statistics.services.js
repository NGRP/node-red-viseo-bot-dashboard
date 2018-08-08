const { getDatabase, getLastConversationID } = require('../../utils/helpers/db-manager.helpers');
const conversationsTable = getDatabase().conversations;


exports.createStatistics = () => {
    return {
        conversationsCount: this.getConversationsCount(),
        messagesCount: this.getMessagesCount(),
        avgMessagesPerDay: this.getAvgMessagesPerDay(),
        todayNewMessages: this.getTodayNewMessages(),
        todayNewConversations: this.getTodayNewConversations(),
    };
};

exports.createBroadcastStatistics = (server) => {
    return {
        type: 'statisticsUpdate',
        payload: this.createStatistics()
    };
};

exports.broadcastStatistics = (server) => {
    server.broadcast(this.createBroadcastStatistics());
};

exports.getConversationsCount = () => {
    return conversationsTable.length;
};

exports.getMessagesCount = () => {
    return conversationsTable
        .reduce((acc, conversation) => acc.concat(conversation.messages), []) // flatMap(conversation => conversation.messages)
        .length
};

exports.getAvgMessagesPerDay = () => {

    const messagesByDays = conversationsTable
        // flatMap messages
        .reduce((acc, conversation) => acc.concat(conversation.messages), [])

        // group message by date
        .reduce((acc, messages) => {
            (acc[getDate(messages.date)] = acc[getDate(messages.date)] || []).push(messages);
            return acc;
        }, {});

    const messagesCountByDays = Object.values(messagesByDays)
        // flatMap messages count by day
        .map(group => group.length);

    // retrieve average
    return messagesCountByDays.reduce((acc, count) => acc + count) / messagesCountByDays.length;
};

exports.getTodayNewMessages = () => {

    const messagesByDays = conversationsTable
    // flatMap messages
        .reduce((acc, conversation) => acc.concat(conversation.messages), [])

        // group message by date
        .reduce((acc, messages) => {
            (acc[getDate(messages.date)] = acc[getDate(messages.date)] || []).push(messages);
            return acc;
        }, {});

    const todayMessagesList =  messagesByDays[getDate(new Date())];
    return todayMessagesList ? todayMessagesList.length : 0;
};


exports.getTodayNewConversations = () => {

    const messagesByDays = conversationsTable
    // flatMap messages
        .reduce((acc, conversation) => acc.concat([conversation.messages[0]]), [])

        // group message by date
        .reduce((acc, messages) => {
            (acc[getDate(messages.date)] = acc[getDate(messages.date)] || []).push(messages);
            return acc;
        }, {});

    const todayMessagesList =  messagesByDays[getDate(new Date())];
    return todayMessagesList ? todayMessagesList.length : 0;
};


const getDate = (date) => {
    const dt = new Date(date);
    return dt.getFullYear() + "/" + (dt.getMonth() + 1) + "/" + dt.getDate();
};
