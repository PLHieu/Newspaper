const { postsLimit } = require('../config/const.config');
const db = require('../utils/db');
const { findChildCategories, findLevel } = require('./category.model');

module.exports = {

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

        if (level == 2) {
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
    }


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