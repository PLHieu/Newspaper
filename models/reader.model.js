const db = require('../utils/db')

module.exports = {
    async findByUsername(username){
        const rows = await db('Readers').where('username', username);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    async add(user){
      return db('Readers').insert(user);
    },
}