const Hapi = require('hapi');

const log = require('./utils/helpers/log.helpers');
const { registerPlugin } = require('./utils/helpers/plugins.helpers');
const { initializeSubscriptions } = require('./utils/helpers/websockets.helpers');
const config = require('./config');

const server = Hapi.server({
    host: config.host,
    port: config.port
});

exports.startServer = async () => {
    try {
        if (config.environment !== 'production') {
            await registerPlugin(server, 'vision');
            await registerPlugin(server, 'inert');
            await registerPlugin(server, 'lout');
        }

        await registerPlugin(server, 'websockets');
        initializeSubscriptions(server);
        await registerPlugin(server, 'health-checks');
        await registerPlugin(server, 'bot');

        await server.start();

        log.info(`Server listening on ${server.info.uri}`);
    } catch (err) {
        log.error(err);
    }
};
