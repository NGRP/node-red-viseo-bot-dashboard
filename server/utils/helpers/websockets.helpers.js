exports.initializeSubscriptions = (server) => {
    server.subscription('/conversations/{id}');
};
