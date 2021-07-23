const db = require('../utils/db')

module.exports = {
    allTags(){
        return db('Tags');
    },

    async findByID(idTag){
        const rows = await db('Tags').where('ID', idTag);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    del(tagID){
        return db('Tags').where('ID', tagID).del();
    }
}