var objectMapper = require('object-mapper');
const { postsLimit } = require('../config/const.config');
const db = require('../utils/db');
const { rule1 } = require('../utils/mapper');
const { findListChild, findChildCategories, findLevel } = require('./category.model');

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

