exports.initializeSubscriptions = (server) => {
    server.subscription('/conversations/{id}');
    server.subscription('/health');

};
