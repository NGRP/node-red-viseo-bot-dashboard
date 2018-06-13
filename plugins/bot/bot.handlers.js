const { sendHTTPRequest } = require('../../utils/helpers/http.helpers');

const config = require('../../config');

const HTTP_NO_CONTENT = 204;

exports.handoverBotFrameworkHandler = async (request, handler) => {
    // TODO: Make a call to bot framework on POST {url}/handover
    // Make the API call using Hapijs/Wreck module

    const payload = {
        ...request.payload,
        handover: request.params.active === 'enable' ? 'on' : 'off'
    };

    const httpOptions = {
        payload,
        baseUrl: config.botOptions.host
    };

    const response = await sendHTTPRequest('POST', '/handover', httpOptions);

    return handler.response(response);
};

exports.sendMessageToBotFrameworkHandler = (request, handler) => {
    // TODO: Make a call to bot framework on POST {url}/sendmessage
    // Make the API call using Hapijs/Wreck module

    // const payload = { ...request.payload };

    // Request

    // Publish on WebSockets if necessary
    return handler.response().code(HTTP_NO_CONTENT);
};
