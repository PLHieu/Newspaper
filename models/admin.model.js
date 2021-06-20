const db = require('../utils/db')

module.exports = {
    async findByUsernamePassword(username, password) {
        const rows = await db('Admins')
            .where(
                {
                    username: username,
                    password: password
                });
        if (rows.length ===0){
            return null;
        }
        return rows; 
    }
}