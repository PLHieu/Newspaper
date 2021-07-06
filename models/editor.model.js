const db = require('../utils/db')

module.exports = {
    async findByUsername(username){
        const rows = await db('Editors').where('username', username);
        if (rows.length === 0)
          return null;
        return rows[0];
      },

    //sure has row
    async getNameByID(id){
      const rows = await db('Editors').where('ID', id);
        if (rows.length === 0)
          return null;
        return rows[0].Name;
    },
}