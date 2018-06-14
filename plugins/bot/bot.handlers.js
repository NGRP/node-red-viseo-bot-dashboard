const { sendHTTPRequest } = require('../../utils/helpers/http.helpers');

const config = require('../../config');

const generateBotFrameworkRequiredOptions = (payload) => {
    return {
        payload,
        headers: { 'Authorization': config.botOptions.token },
        baseUrl: config.botOptions.host
    };
};

exports.handoverBotFrameworkHandler = async (request, handler) => {
    // TODO: Make a call to bot framework on POST {url}/handover
    // Make the API call using Hapijs/Wreck module

    const payload = {
        ...request.payload,
        handover: request.params.active === 'enable' ? 'on' : 'off'
    };

    const httpOptions = {
        ...generateBotFrameworkRequiredOptions(),
        payload
    };

    const response = await sendHTTPRequest('POST', '/handover', httpOptions);

    // Publish on WebSockets if necessary
    // Access websocket through request.server and use the hapijs/nes functions

    return handler.response(response);
};

exports.sendMessageToBotFrameworkHandler = async (request, handler) => {
    // TODO: Make a call to bot framework on POST {url}/sendmessage
    // Make the API call using Hapijs/Wreck module

    const payload = { ...request.payload };

    const httpOptions = {
        ...generateBotFrameworkRequiredOptions(),
        payload
    };

    const response = await sendHTTPRequest('POST', '/handover', httpOptions);

    // Publish on WebSockets if necessary
    // Access websocket through request.server and use the hapijs/nes functions

    return handler.response(response);
};
