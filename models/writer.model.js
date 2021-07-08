const db = require('../utils/db')

module.exports = {
    async findByUsername(username){
        const rows = await db('Writers').where('username', username);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    async findByID(id){
      const rows = await db('Writers').where('ID', id);
      if (rows.length === 0)
        return null;
      return rows[0];
    },

    async findByEmail(email){
      const rows = await db('Writers').where('Email', email);
      if (rows.length === 0)
        return null;
      return rows[0];
    },

    changePassByID(hash,ID){
      return db('Writers').where('ID', ID).update('Password',hash);
    },
}