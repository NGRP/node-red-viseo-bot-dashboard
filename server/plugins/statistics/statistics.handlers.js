const services = require('./statistics.services');

exports.getStatisticsHandler = async () => {
    return services.createStatistics();
};
