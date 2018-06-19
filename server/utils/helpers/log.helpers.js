const MAX_DOTTED_LENGTH = exports.MAX_DOTTED_LENGTH = 30;

const info = exports.info = (message) => {
    return console.info(message); // eslint-disable-line
};

const error = exports.error = (message) => {
    return console.error(message); // eslint-disable-line
};

exports.logModule = (plugin, err) => {
    let text = plugin.toLocaleUpperCase().replace('-', '');

    for (let i = text.length; i < MAX_DOTTED_LENGTH; i++) {
        text += '.';
    }

    if (err) {
        return error(`${text}ERROR`);
    } else {
        return info(`${text}OK`);
    }
};
