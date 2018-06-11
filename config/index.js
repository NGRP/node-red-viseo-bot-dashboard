const Joi = require('joi');

const { configSchema } = require('./config.validators');
const config = require('./config.json');

const result = Joi.validate(config, configSchema);

if (result.error !== null) {
    throw result.error;
}

module.exports = exports = {
    ...config
};
