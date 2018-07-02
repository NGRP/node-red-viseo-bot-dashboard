const { getDatabase } = require('../../utils/helpers/db-manager.helpers');
const usersTable = getDatabase().users;

exports.getUserList = () => {
    return new Promise((resolve, reject) => {
        try {
            const formattedUsers = usersTable.map((user) => {
                const filteredUser = { ...user };
                delete filteredUser.password;

                return { ...filteredUser };
            });

            return resolve([ ...formattedUsers ]);
        } catch (error) {
            return reject(error);
        }
    });
};
