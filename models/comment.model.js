const db = require('../utils/db');
const reader_db = require('./reader.model');
const writer_db = require('./writer.model');
const editor_db = require('./editor.model');
const admin_db = require('./admin.model');
const moment = require('moment');

module.exports = {
    addComment(new_comment){
        return db('Comments').insert(new_comment);
   },

   delComment(id_comment){
       return db('Comments').where('ID', id_comment).del();
   },

   delAllCommentsByPostID(postID){
    return db('Comments').where('PostID', postID).del();
   },

   updateComment(id_comment, new_content){
       return db('Comments').where('ID', id_comment).update('Content',new_content);
   },

   async findCommentByID(id_post){
    const rows = await db('Comments').where('PostID', id_post);
    for (let i = 0; i < rows.length; i++) {
        if (rows[i].ReaderID != null) {
            const readers_comment = await db_role_reader_commented(rows[i].RoleReaderID,rows[i].ReaderID);
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

function db_role_reader_commented(role, ReaderID){
    switch(role){
        case 'writer':
            return writer_db.findByID(ReaderID);
        case 'editor':
            return editor_db.findByID(ReaderID);
            case 'admin':
                return admin_db.findByID(ReaderID);
        default:
            return reader_db.findByID(ReaderID);
    }
}