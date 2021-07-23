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

    async findByTagName(tagName){
        const rows = await db('Tags').where('Name', tagName);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    add(tagName){
        tag = {Name: tagName};
        return db('Tags').insert(tag);
    },

    del(tagID){
        return db('Tags').where('ID', tagID).del();
    }
}