var objectMapper = require('object-mapper');
const { postsLimit } = require('../config/const.config');
const db = require('../utils/db');
const { rule1 } = require('../utils/mapper');
const { findListChild, findChildCategories, findLevel } = require('./category.model');
const posttag_db = require('./post_tag.model');
const comment_db = require('./comment.model');
const writer_db = require('./writer.model');
const cate_db = require('./category.model');
const moment = require('moment');

module.exports = {

    findByWriterID(writerID){
        return db('Posts').where('WriterID', writerID);
    },

    /*
    Tim bai viet theo Category
    */
    async findByCategory(IDcategory, offset) {
        let level = await findLevel(IDcategory);
        // console.log(level);
        if (level == false) {
            return false;
        }

        if (level === 1) {
            return await findByLevel1Category(IDcategory, offset);
        }

        if (level === 2) {
            return await findByLevel2Category(IDcategory, offset);
        }
    },

    /*
    Tim bai viet theo Tag
    */
    async findByTag(IDTag, offset) {
        const listPostIDs = await findPostIDByTag(IDTag);
        const rows = await db('Posts')
            .whereIn('ID', listPostIDs)
            .orderBy('PubTime', 'desc')
            .limit(postsLimit)
            .offset(offset);
        return rows;
    },

    /*
    Tim cac Tag cua 1 Bai Viet cu the
    */
    async findTagsOfPost(postID) {
        // console.log(postID)
        const rows = await db('PostTag')
            .join('Tags', 'PostTag.TagID', '=', 'Tags.ID')
            .where({
                PostID: postID
            })
            .select('PostTag.TagID', 'Tags.Name')
        // console.log(rows);
        return rows;
    },

    /*
    Tim danh sach bai viet theo Tag
    */
    async findPostsByTag(tagID, offset) {
        const posts = await findPostIDByTag(tagID);
        const postIDs = posts.map(p => p.PostID);
        // console.log(postIDs);
        const listPosts = await db('Posts')
            .whereIn('ID', postIDs)
            .orderBy('PubTime', 'desc')
            .limit(postsLimit)
            .offset(offset);
        return listPosts;
    },
    async countPostByCategory(IDcategory) {
        const level = await findLevel(IDcategory);
        if (level === 1) {
            return await countByLevel1Category(IDcategory);
        }

        if (level === 2) {
            return await countByLevel2Category(IDcategory);
        }
    },

    async countPostByTag(IDTag) {
        const rows = await db('PostTag')
            .where('TagID', IDTag)
            .count('*', { as: 'total' });
        // console.log(rows);
        return rows[0].total;
    },

    /*
        Tim danh sach bai viet NOIBAT theo Tag
    */
    async findHightlightPostsByTag(tagID, limit, offset) {
        const posts = await findPostIDByTag(tagID);
        const postIDs = posts.map(p => p.PostID);
        // console.log(postIDs);
        const listPosts = await db('Posts')
            .whereIn('ID', postIDs)
            .orderBy('Views', 'desc')
            .limit(limit)
            .offset(offset);
        // console.log(listPosts);
        return listPosts;
    },
    /*
    Tim bai viet NOIBAT theo Category
    */
    async findHightlightByCategory(IDcategory, limit, offset) {
        let level = await findLevel(IDcategory);
        // console.log(level);
        if (level == false) {
            return false;
        }
        if (level === 1) {
            return await findHightlightByLevel1Category(IDcategory, limit, offset);
        }
        return await findHightlightByLevel2Category(IDcategory, limit, offset);
    },
    /*
    Tim top 10 bài viết xem nhiều nhất
    */
    async findTop10MostRead() {
        const rows = await db('Posts')
            .orderBy('Views', 'desc')
            .limit(10)
        return rows;
    },
    async findTop10New() {
        const rows = await db('Posts')
            .orderBy('PubTime', 'desc')
            .limit(10);
        //console.log(rows);
        return rows;
    },
    
    async findTop1PostPerCate() {
        let childCate =[];
        let child = await findListChild();
        for (let i =0; i<child.length; i++){
            let count = await countByLevel2Category(child[i].ID)

            if (count > 0){
                childCate.push(child[i]);
            }
        }
        //console.log(childCate);
        let listCate = [];
        for (let i =0; i<childCate.length; i++){
            let des = objectMapper(childCate[i], rule1)
            let post = await findHightlightByLevel2Category(childCate[i].ID, 1, 0)
            des.Name = childCate[i].Name;
            console.log(childCate[i].ParentID);
            let parent = await cate_db.findNameCateByID(childCate[i].ParentID);
            console.log(parent);
            des.ParentCateName= parent;
            des.post=post;
            listCate.push(des);
        }
        while(listCate.length > 10) {
            listCate.pop()
        };
        //console.log(listCate);
        return listCate;
    },
    async top3Post() {
        var d = new Date();
        d.setDate(d.getDate()-7);
        // console.log(rows);
        //return rows;
        const rows = await db('Posts')
            .where('WriteTime','>',d)
            .orderBy('Views', 'desc')
            .limit(3);
        return rows;
    },
    /*
    Tim danh sach ID bai viet theo Tag
    */
    async findNameCateByID(IDCate) {
        const rows = await db('Categories')
            .where({
                ID: IDCate,
            })
            .select('Name');
        //console.log(rows);
        return rows;
    },

    async findPostByID(id_post){
        const post = await findOnlyByID(id_post);
        post.Writer = await writer_db.findByID(post.WriterID);
        post.CatName = await cate_db.findNameCateByID(post.CatID);
        await upView(id_post,post.Views + 1);
        post.Views += 1;
        post.PubTime = moment(post.PubTime).format("DD/MM/YYYY HH:mm:ss");
        post.tags = await posttag_db.findTagsByPostID(id_post);
        post.comments = await comment_db.findCommentByID(id_post);
        post.num_comments = post.comments.length;
        five_post_like_cat = await findRelatedPostByCatID(post.ID,post.CatID);
        for (let i = 0; i <five_post_like_cat.length; i++){
            p = five_post_like_cat[i];
            tags = await posttag_db.findTagsByPostID(p.ID);
            five_post_like_cat[i].tags = tags;
            five_post_like_cat[i].PubTime = moment(five_post_like_cat[i].PubTime).format("DD/MM/YYYY");
            console.log(five_post_like_cat[i].WriterID);
            five_post_like_cat[i].Writer = await writer_db.findByID(five_post_like_cat[i].WriterID);
            five_post_like_cat[i].CatName = await cate_db.findNameCateByID(five_post_like_cat[i].CatID);
        }
        //console.log(five_post_like_cat);
        post.five_post_like_cat = five_post_like_cat;
        return post;
   },

   addPost(new_post){
    return db('Posts').insert(new_post);
    },

    editPost(edit_post, postID){
    return db('Posts').update(edit_post).where('ID',postID);
    },

    delPost(postID){
        return db('Posts').where('ID',postID).del();
    },

    async findPostByTitleWriter(title, writerID){
        const rows = await db('Posts').where('Title', title).andWhere('WriterID', writerID);
        if (rows.length === 0)
            return null;
        return rows[0];
    },

    async indRelatedPostByCatID(postID,catID){
        const offset = 5;
        return await db('Posts').whereNot('ID', postID).andWhere('CatID', catID).limit(offset);
    },
}

function findRelatedPostByCatID(postID,catID){
    const offset = 5;
    return db('Posts').whereNot('ID', postID).andWhere('CatID', catID).andWhereNot('PubTime', null).limit(offset);
};

function upView(postID, new_View){
    return db('Posts').where('ID', postID).update('Views',new_View);//post.Views
}

async function findOnlyByID(postID){
    const rows = await db('Posts').where('ID', postID);
    if (rows.length === 0)
        return null;
    return rows[0];
}

/*
    Tim danh sach ID bai viet theo Tag
*/
async function findPostIDByTag(IDTag) {
    const rows = await db('PostTag')
        .where({
            TagID: IDTag,
        });
    return rows;
}

/*
    Tim bai viet theo Category o Level 1 (cao)
*/
async function findByLevel1Category(IDcategory, offset) {
    const childrenCate = await findChildCategories(IDcategory);
    const childrenCateID = childrenCate.map(ele => ele.ID);
    // console.log(childrenCateID);
    const rows = await db('Posts')
        .whereIn('CatID', childrenCateID)
        .orderBy('PubTime', 'desc')
        .limit(postsLimit)
        .offset(offset)
    return rows;
}

/*
    Tim bai viet theo Category o Level 2 (thap)
*/
async function findByLevel2Category(IDcategory, offset) {
    const rows = await db('Posts')
        .where({
            CatID: IDcategory,
        })
        .orderBy('PubTime', 'desc')
        .limit(postsLimit)
        .offset(offset)
    return rows;
}
/*
    So Luong bai viet theo Category o Level 2 (thap)
*/
async function countByLevel2Category(IDcategory) {
    const rows = await db('Posts')
        .where({
            CatID: IDcategory,
        })
        .count('*', { as: 'total' })
    return rows[0].total;
}
/*
    So Luong bai viet theo Category o Level 1 (cao)
*/
async function countByLevel1Category(IDcategory) {
    const childrenCate = await findChildCategories(IDcategory);
    const childrenCateID = childrenCate.map(ele => ele.ID);
    const rows = await db('Posts')
        .whereIn('CatID', childrenCateID)
        .count('*', { as: 'total' })
    return rows[0].total;
}
/*
    Tim bai viet NOIBAT theo Category o Level 1 (cao)
*/
async function findHightlightByLevel1Category(IDcategory, limit, offset) {
    const childrenCate = await findChildCategories(IDcategory);
    const childrenCateID = childrenCate.map(ele => ele.ID);
    // console.log(childrenCateID);
    const rows = await db('Posts')
        .whereIn('CatID', childrenCateID)
        .orderBy('Views', 'desc')
        .limit(limit)
        .offset(offset)
    return rows;
}

/*
    Tim bai viet NOIBAT theo Category o Level 2 (thap)
*/
async function findHightlightByLevel2Category(IDcategory, limit, offset) {
    const rows = await db('Posts')
        .where({
            CatID: IDcategory,
        })
        .orderBy('Views', 'desc')
        .limit(limit)
        .offset(offset)
    return rows;
}

