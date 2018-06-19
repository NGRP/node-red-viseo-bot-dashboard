const Wreck = require('wreck');

exports.sendHTTPRequest = async (method, uri, options) => {
    // Wreck calls being an HAPI module, they will throw Hapijs/Boom error object on error,
    // which will be caught by HAPI to send back the appropriate HTTP response.
    // If you want to handle the error yourself, try/catch the block and use the Hapijs/Boom module
    // to throw another error in the catch block.
    const response = await Wreck.request(method, uri, options);
    const body = await Wreck.read(response);

    return {
        statusCode: response.statusCode,
        body
    };
};
