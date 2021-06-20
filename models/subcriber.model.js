const db = require('../utils/db')

module.exports = {
    async findByUsernamePassword(username, password) {
        const rows = await db('Readers')
            .where(
                {
                    username: username,
                    password: password
                })
            .whereNotNull('ExpTime');
        if (rows.length ===0){
            return null;
        }
        return rows; 
    }
}