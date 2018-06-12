const fs = require('fs');
const path = require('path');

const log = require('./log.helpers');

const extractPluginName = (pluginName) => {
    return fs.existsSync(path.resolve(__dirname, `../../plugins/${pluginName}`))
        ? `../../plugins/${pluginName}`
        : pluginName;
};

exports.extractPluginName = extractPluginName;

exports.registerPlugin = async (server, pluginName, pluginOptions) => {
    try {
        await server.register(require(extractPluginName(pluginName)), pluginOptions);

        log.logModule(pluginName);
    } catch (err) {
        log.logModule(pluginName, true);
        throw err;
    }
};
