const log = require('./log.helpers');

exports.registerPlugin = async (server, pluginName) => {
    try {
        await server.register(require(`../../plugins/${pluginName}`));

        log.logModule(pluginName);
    } catch (err) {
        log.logModule(pluginName, true);
        throw err;
    }
};
