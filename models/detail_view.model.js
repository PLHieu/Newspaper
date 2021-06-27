const db = require('../utils/db');
const moment = require('moment');

module.exports = {
    async findPostByID(id_post){
        const rows = await db('Posts').where('ID', id_post);
        if (rows.length === 0)
          return null;
        const post = rows[0];

        const WriterPost = await db('Writers').where('ID', post.WriterID);
        post.WriterName = WriterPost[0].Name;
        const CatPost = await db('Categories').where('ID', post.CatID)
        post.CatName = CatPost[0].Name;
        await db('Posts').where('ID', id_post).update('Views',post.Views + 1);//post.Views
        post.Views += 1;
        post.PubTime = moment(post.PubTime).format("DD/MM/YYYY HH:mm:ss");
        const tags = await db('PostTag').where('PostID', id_post);
        if (tags.length > 0){
            for (let i = 0; i < tags.length; i++) {
                tag = await db('Tags').where('ID', tags[i].TagID);
                tags[i] = tag[0];
              }
        }
        post.tags = tags;
        return post;
   },

   async findCommentByID(id_post){
        const rows = await db('Comments').where('PostID', id_post);
        for (let i = 0; i < rows.length; i++) {
            if (rows[i].ReaderID != null) {
                const readers_comment = await db('Readers').where('ID', rows[i].ReaderID);
                rows[i].ReaderName = readers_comment[0].Name;
            }
            else{
                rows[i].ReaderName = "Guest";
            }
            rows[i].PubTime =moment(rows[i].PubTime).format("DD/MM/YYYY HH:mm:ss")
        }
        return rows;
   },

    addComment(new_comment){
        return db('Comments').insert(new_comment);
   },

   delComment(id_comment){
       return db('Comments').where('ID', id_comment).del();
   },

   updateComment(id_comment, new_content){
       return db('Comments').where('ID', id_comment).update('Content',new_content);
   }
}