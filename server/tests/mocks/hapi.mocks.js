const sinon = require('sinon');

const startMethodSuccess = async () => {
    return new Promise(resolve => resolve());
};
const startMethodFailure = async () => {
    return new Promise((resolve, reject) => reject());
};
const startSpySuccess = sinon.spy(startMethodSuccess);
const startSpyFailure = sinon.spy(startMethodFailure);
const server = {
    start: startSpySuccess,
    register: async () => new Promise(resolve => resolve())
};

const serverMethod = ({ host, port }) => {
    server.info = { uri: `http://${host}:${port}` };
    return server;
};

const serverSpy = sinon.spy(serverMethod);

exports.server = serverSpy;
exports.start = startSpySuccess;

exports.setError = () => {
    server.start = startSpyFailure;
    exports.start = startSpyFailure;
};
