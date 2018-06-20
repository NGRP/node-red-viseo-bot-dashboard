const Joi = require('joi');

const { ENVIRONMENTS, MINIMUM_PORT_VALUE, MAXIMUM_PORT_VALUE } = require('../utils/constants/validators.constants');

const botOptionsSchema = {
    host: Joi.alternatives().try(
        Joi.string().uri(),
        Joi.string().ip(),
        Joi.string().regex(/localhost/)
    ).required(),
    token: Joi.string().required()
};

exports.configSchema = {
    host: Joi.alternatives().try(
        Joi.string().uri(),
        Joi.string().ip(),
        Joi.string().regex(/localhost/)
    ).required(),
    port: Joi.number().integer().positive().min(MINIMUM_PORT_VALUE).max(MAXIMUM_PORT_VALUE).required(),
    botOptions: Joi.object().keys(botOptionsSchema).required(),
    environment: Joi.string().valid(ENVIRONMENTS).required()
};
