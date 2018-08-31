exports.initializeSubscriptions = (server) => {
    server.subscription('/conversations/{id}');
    server.subscription('/conversations');
    server.subscription('/health');
};

exports.publishNewMessage = (server, id, message) => {
    return new Promise((resolve) => {
        server.publish(`/conversations/${id}`, message);
        return resolve();
    });
};

exports.publishNewConversation = (server, data) => {
    return new Promise((resolve) => {
        server.publish('/conversations', data);
        return resolve();
    });
};
