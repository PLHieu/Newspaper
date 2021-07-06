const db = require('../utils/db');
const reader_db = require('./reader.model');
const moment = require('moment');

module.exports = {
    addComment(new_comment){
        return db('Comments').insert(new_comment);
   },

   delComment(id_comment){
       return db('Comments').where('ID', id_comment).del();
   },

   updateComment(id_comment, new_content){
       return db('Comments').where('ID', id_comment).update('Content',new_content);
   },

   async findCommentByID(id_post){
    const rows = await db('Comments').where('PostID', id_post);
    for (let i = 0; i < rows.length; i++) {
        if (rows[i].ReaderID != null) {
            const readers_comment = await reader_db.findByID(rows[i].ReaderID);
            rows[i].ReaderName = readers_comment.Name;
        }
        else{
            rows[i].ReaderName = "Guest";
        }
        rows[i].PubTime =moment(rows[i].PubTime).format("DD/MM/YYYY HH:mm:ss")
    }
    return rows;
    },
};