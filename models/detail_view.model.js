const db = require('../utils/db');
const moment = require('moment');
const post_cat_tag_db = require('../models/post.model');

module.exports = {
    async findPostByID(id_post){
        const rows = await db('Posts').where('ID', id_post);
        if (rows.length === 0)
          return null;
        const post = rows[0];

        const WriterPost = await db('Writers').where('ID', post.WriterID);
        post.Writer= WriterPost[0];
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
        post.comments = await findCommentByID(id_post);
        post.num_comments = post.comments.length;
        five_post_like_cat = await post_cat_tag_db.findByCategory(post.CatID, 5);
        for (let i = 0; i <five_post_like_cat.length; i++){
            p = five_post_like_cat[i];
            tags = await findTagsByPostID(p.ID);
            five_post_like_cat[i].tags = tags;
        }
        post.five_post_like_cat = five_post_like_cat;
        console.log(post);
        return post;
   },

   async full_text_search(text_search){
       const query = `SELECT * FROM Posts WHERE MATCH (Title, Abstract,Content) AGAINST (${text_search} IN NATURAL LANGUAGE MODE)\G`;
       return await db('Posts').raw(query);
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
};

async function findCommentByID(id_post){
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
};

async function findTagsByPostID(id_post){
     tags_id = await db('PostTag').where('PostID', id_post);
     if (tags.length > 0){
         for (let i = 0; i < tags.length; i++) {
             tag = await db('Tags').where('ID', tags[i].TagID);
             tags[i] = tag[0];
         }
         return tags;
     }
     return null;
};