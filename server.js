const Hapi = require('hapi');

const log = require('./utils/helpers/log.helpers');
const { registerPlugin } = require('./utils/helpers/plugins.helpers');
const config = require('./config');

const server = Hapi.server({
    host: config.host,
    port: config.port
});

exports.startServer = async () => {
    try {
        await registerPlugin(server, 'health-checks');
        await server.start();

        log.info(`Server listening on ${server.info.uri}`);
    } catch (err) {
        log.error(err);
    }
};
