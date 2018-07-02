const Boom = require('boom');

const { getDatabase } = require('../../utils/helpers/db-manager.helpers');
const usersTable = getDatabase().users;

const strippedPasswordUser = (user) => {
    const formatted = { ...user };
    delete formatted.password;

    return { ...formatted };
};

exports.getUserList = () => {
    return new Promise((resolve, reject) => {
        try {
            const formattedUsers = usersTable.map((user) => {
                return strippedPasswordUser(user);
            });

            return resolve([ ...formattedUsers ]);
        } catch (error) {
            return reject(error);
        }
    });
};

exports.login = ({ username, password }) => {
    return new Promise((resolve, reject) => {
        try {
            const match = usersTable.find((user) => {
                return username === user.username
                    && password === user.password;
            });

            if (match) {
                return resolve(strippedPasswordUser(match));
            } else {
                const error = Boom.unauthorized('Username and/or password incorrect');
                return reject(error);
            }
        } catch (error) {
            return reject(error);
        }
    });
};
