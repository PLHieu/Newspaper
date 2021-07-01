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