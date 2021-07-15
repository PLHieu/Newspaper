const db = require('../utils/db');
const { add } = require('./reader.model');

module.exports = {
    async findByID(draftID){
        const rows = await db('Drafts').where('ID', draftID);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    //return a row
    async findByPostID(postID){
        const rows = await db('Drafts').where('PostID', postID);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    //return list
    findByEditorID(editorID){
        return db('Drafts').where('EditorID', editorID);
    },
    
    add(draft){
      return db('Drafts').insert(draft);
    },

    delete(postID){
      return db('Drafts').where('PostID', postID).del();
    }
}