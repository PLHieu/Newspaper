const db = require('../utils/db')

module.exports = {
    allTags(){
        return db('Tags');
    },

    async findByID(draftID){
        const rows = await db('Tags').where('ID', draftID);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    findByPostID(postID){
        return db('Drafts').where('PostID', postID);
    },

    findByEditorID(editorID){
        return db('Drafts').where('EditorID', editorID);
    }
}