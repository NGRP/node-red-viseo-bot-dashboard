exports.plugin = require('nes');
exports.options = {
    onConnection: async (socket) => {
        await socket.send({ connected: true });
    },
    heartbeat: false
};
