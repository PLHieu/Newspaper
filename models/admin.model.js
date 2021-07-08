const db = require('../utils/db')

module.exports = {
    async findByUsername(username){
        const rows = await db('Admins').where('username', username);
        if (rows.length === 0)
          return null;
        return rows[0];
      },

      async findByID(id){
        const rows = await db('Admins').where('ID', id);
        if (rows.length === 0)
          return null;
        return rows[0];
      },
}