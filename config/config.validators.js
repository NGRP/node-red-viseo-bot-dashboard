const Joi = require('joi');

const MINIMUM_PORT_VALUE = 1025;
const MAXIMUM_PORT_VALUE = 65535;

exports.configSchema = {
    host: Joi.alternatives().try(
        Joi.string().uri(),
        Joi.string().ip(),
        Joi.string().regex(/localhost/)
    ).required(),
    port: Joi.number().integer().positive().min(MINIMUM_PORT_VALUE).max(MAXIMUM_PORT_VALUE).required()
};
