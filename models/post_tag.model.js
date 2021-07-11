const db = require('../utils/db');
const tag_db = require('./tag.model')

module.exports = {
    async findTagsByPostID(id_post){
        tags = await db('PostTag').where('PostID', id_post);
        if (tags.length > 0){
            for (let i = 0; i < tags.length; i++) {
                tags[i] = await tag_db.findByID(tags[i].TagID);
            }
            return tags;
        }
        return null;
   },

   add(postTag){
    return db('PostTag').insert(postTag);
   },

   edit(postTag){
       return db('PostTag').where('PostID',postTag.PostID).update('TagID',postTag.TagID);
   },

   del(postID){
    return db('PostTag').where('PostID',postID).del();
   }
}