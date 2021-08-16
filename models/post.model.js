var objectMapper = require('object-mapper');
const { postsLimit } = require('../config/const.config');
const db = require('../utils/db');
const { rule1, ruleCate, ruleTag } = require('../utils/mapper');
const { findListChild, findChildCategories, findLevel } = require('./category.model');
const posttag_db = require('./post_tag.model');
const comment_db = require('./comment.model');
const writer_db = require('./writer.model');
const cate_db = require('./category.model');
const draft_db = require('./draft.model');
const editor_db = require('./editor.model');

const moment = require('moment');

module.exports = {

    all(){
        return db('Posts');
    },

    findByWriterID(writerID) {
        return db('Posts').where('WriterID', writerID);
    },

    /*
    Tim bai viet theo Category da public
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
    Tim tat ca bai viet theo Category
    */
    async findAllByCategory(IDcategory, offset) {
        let level = await findLevel(IDcategory);
        // console.log(level);
        if (level == false) {
            return false;
        }

        if (level === 1) {
            return await findAllByLevel1Category(IDcategory, offset);
        }

        if (level === 2) {
            return await findAllByLevel2Category(IDcategory, offset);
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
        let now = new Date();
        const listPosts = await db('Posts')
            .whereIn('ID', postIDs)
            .andWhere({
                StateID: 1,
            })
            .andWhere('PubTime', '<=', now)
            .orderBy([{ column: 'Premium', order: 'desc' }, { column: 'PubTime', order: 'desc' }])
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
    async countAcceptPostByCategory(IDcategory) {
        let count = await db('Posts')
                        .where({
                            CatID: IDcategory,
                            StateID: 1,
                        });
        return count.length;

    },
    async countRefusePostByCategory(IDcategory) {
        let count = await db('Posts')
                        .where({
                            CatID: IDcategory,
                            StateID: -1,
                        });
        return count.length;

    },
    async countChuaDuyetPostByCategory(IDcategory) {
        let count = await db('Posts')
                        .where({
                            CatID: IDcategory,
                        })
                        .whereIn('StateID', [-2, 0]);
        return count.length;

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
        let now = new Date();
        const rows = await db('Posts')
            .where({
                StateID: 1,
            })
            .andWhere('PubTime', '<=', now)
            .orderBy('Views', 'desc')
            .limit(10)
        return rows;
    },
    async findTop10New() {
        var now = new Date();
        const rows = await db('Posts')
            .where({
                StateID: 1,
            })
            .andWhere('PubTime', '<=', now)
            .orderBy('PubTime', 'desc')
            .limit(10);
        //console.log(rows);
        return rows;
    },

    async findTop1PostPerCate() {
        let childCate = [];
        let child = await findListChild();
        for (let i = 0; i < child.length; i++) {
            let count = await countByLevel2Category(child[i].ID)

            if (count > 0) {
                childCate.push(child[i]);
            }
        }
        //console.log(childCate);
        let listCate = [];
        for (let i = 0; i < childCate.length; i++) {
            let des = objectMapper(childCate[i], ruleCate)
            let post = await findNewPostByLevel2Category(childCate[i].ID, 1, 0)
            let parent = await cate_db.findNameCateByID(childCate[i].ParentID);
            // console.log(parent);
            des.ParentCateName = parent;
            des.post = post;
            listCate.push(des);
        }
        while (listCate.length > 10) {
            listCate.pop()
        };
        //console.log(listCate);
        return listCate;
    },
    async top3Post() {
        var d = new Date();
        var now = new Date();
        d.setDate(d.getDate() - 7);
        // console.log(rows);
        //return rows;
        const rows = await db('Posts')
            .where('PubTime', '>', d)
            .where({
                StateID: 1,
            })
            .andWhere('PubTime', '<=', now)
            .orderBy('Views', 'desc')
            .limit(3);
        return rows;
    },

    changeStateID(postID,newStateID){
        return db('Posts').where('ID',postID).update('StateID', newStateID);
    },

    updateEditor(postID,editorID){
        return db('Posts').where('ID',postID).update('EditorID', editorID);
    },

    updateApprovePost(postID,catID,pubTime){
        return db('Posts').where('ID',postID)
        .update({PubTime:pubTime,
                    CatID: catID
                });
    },

    async findByID(postID){
        const post = await findOnlyByID(postID);
        post.PubTime = moment(post.PubTime).format("DD/MM/YYYY HH:mm:ss");
        post.tags = await posttag_db.findTagsByPostID(postID);
        return post;
    },


    async findPostByID(id_post) {
        const post = await findOnlyByID(id_post);
        if (post === null)
            return null;
        post.Writer = await writer_db.findByID(post.WriterID);
        post.CatName = await cate_db.findNameCateByID(post.CatID);
        await upView(id_post, post.Views + 1);
        post.Views += 1;
        post.WriteTime = moment(post.WriteTime).format("DD/MM/YYYY HH:mm:ss");
        post.PubTime = moment(post.PubTime).format("DD/MM/YYYY HH:mm:ss");
        post.tags = await posttag_db.findTagsByPostID(id_post);
        post.comments = await comment_db.findCommentByID(id_post);
        post.num_comments = post.comments.length;
        post.five_post_like_cat = await findRelatedPostByCatID(post.ID, post.CatID);
        post.has_five_post_like_cat = post.five_post_like_cat.length;
        return post;
    },

    addPost(new_post) {
        return db('Posts').insert(new_post);
    },

    editPost(edit_post, postID) {
        return db('Posts').update(edit_post).where('ID', postID);
    },

    async delPost(postID) {
        await comment_db.delAllCommentsByPostID(postID);
        await draft_db.delete(postID);
        await posttag_db.del(postID);
        return db('Posts').where('ID', postID).del();
    },

    async findDraftPostsByCatID(catID){
        const rows = await db('Posts').whereNotIn('StateID', [1,-1]).andWhere('CatID', catID).orderBy('WriteTime');
        for (let i = 0; i < rows.length; i++){
            rows[i].WriterName = await writer_db.findNameByID(rows[i].WriterID);
            rows[i].tags = await posttag_db.findTagsByPostID(rows[i].ID);
            rows[i].WriteTime =  moment(rows[i].WriteTime).format("DD/MM/YYYY HH:mm:ss");
        }
        return rows;
    },

    async findPostByTitleWriter(title, writerID) {
        const rows = await db('Posts').where('Title', title).andWhere('WriterID', writerID);
        if (rows.length === 0)
            return null;
        return rows[0];
    },

    async findRejectedPostsByEditor(editorID){
        const rejectPosts = await db('Posts').where('StateID', -1).andWhere('EditorID', editorID);
        for (let i = 0; i < rejectPosts.length; i++) {
            rejectPosts[i].WriterName = await writer_db.findNameByID(rejectPosts[i].WriterID);
            postID = rejectPosts[i].ID;
            rejectPosts[i].draft_info = await draft_db.findByPostID(postID);
            rejectPosts[i].draft_info.EditorName = await editor_db.getNameByID(editorID);
            rejectPosts[i].draft_info.RateTime = moment(rejectPosts[i].draft_info.RateTime).format("DD/MM/YYYY HH:mm:ss");
        }
        return rejectPosts;
    },

    async findApprovedPostsByEditor(editorID){
        const rows = await db('Posts').where('StateID', 1).andWhere('EditorID', editorID);
        for (let i=0; i<rows.length; i++) {
            rows[i].WriterName = await writer_db.findNameByID(rows[i].WriterID);
            rows[i].PubTime = moment(rows[i].PubTime).format("DD/MM/YYYY")
            rows[i].WriteTime = moment(rows[i].WriteTime).format("DD/MM/YYYY")
        }
        return rows;
    },

    //return a list
    findPendingPosts(writerID) {
        return db('Posts').whereIn('StateID', [0,-2]).andWhere('WriterID', writerID);
    },

    //return a list
    findApprovedNotPublishPosts(writerID) {
        const now = new Date();
        return db('Posts').where('StateID', 1).andWhere('PubTime', '>', now).andWhere('WriterID', writerID);
    },

    //return a list
    findPublishedPosts(writerID) {
        const now = new Date();
        return db('Posts').where('StateID', 1).andWhere('PubTime', '<=', now).andWhere('WriterID', writerID);
    },

    //return a list
    async findRejectedPosts(writerID, stateID) {
        const rejectPosts = await db('Posts').where('StateID', stateID).andWhere('WriterID', writerID);
        for (let i = 0; i < rejectPosts.length; i++) {
            postID = rejectPosts[i].ID;
            rejectPosts[i].draft_info = await draft_db.findByPostID(postID);
            editorID = rejectPosts[i].draft_info.EditorID;
            rejectPosts[i].draft_info.EditorName = await editor_db.getNameByID(editorID);
            rejectPosts[i].draft_info.RateTime = moment(rejectPosts[i].draft_info.RateTime).format("DD/MM/YYYY HH:mm:ss");
        }
        return rejectPosts;
    },

    // dem so bai viet theo writer da viet 
    async countPostByWriterID(writerID){
        let r = await db('Posts')
        .count('ID', {as: 'num_posts'})
        .where({
            WriterID: writerID
        })
        return r[0].num_posts;
    }
}

async function findRelatedPostByCatID(postID, catID) {
    const offset = 5;
    const five_post_like_cat = db('Posts').whereNot('ID', postID).andWhere('CatID', catID).andWhere('PubTime', '<=', new Date()).limit(offset);
    for (let i = 0; i < five_post_like_cat.length; i++) {
        p = five_post_like_cat[i];
        tags = await posttag_db.findTagsByPostID(p.ID);
        five_post_like_cat[i].tags = tags;
        five_post_like_cat[i].PubTime = moment(five_post_like_cat[i].PubTime).format("DD/MM/YYYY");
        five_post_like_cat[i].Writer = await writer_db.findByID(five_post_like_cat[i].WriterID);
        five_post_like_cat[i].CatName = await cate_db.findNameCateByID(five_post_like_cat[i].CatID);
    }
    return five_post_like_cat;
};

function upView(postID, new_View) {
    return db('Posts').where('ID', postID).update('Views', new_View); //post.Views
}

async function findOnlyByID(postID) {
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
    Tim bai viet theo Category o Level 1 (cao) da public
*/
async function findByLevel1Category(IDcategory, offset) {
    const childrenCate = await findChildCategories(IDcategory);
    const childrenCateID = childrenCate.map(ele => ele.ID);
    // console.log(childrenCateID);
    let now = new Date();
    const rows = await db('Posts')
        .whereIn('CatID', childrenCateID)
        .andWhere({
            StateID: 1
        })
        .andWhere('PubTime', '<=', now)
        .orderBy([{ column: 'Premium', order: 'desc' }, { column: 'PubTime', order: 'desc' }])
        .limit(postsLimit)
        .offset(offset)
    return rows;
}

/*
    Tim tat ca bai viet theo Category o Level 1 (cao)
*/
async function findAllByLevel1Category(IDcategory, offset) {
    const childrenCate = await findChildCategories(IDcategory);
    const childrenCateID = childrenCate.map(ele => ele.ID);
    // console.log(childrenCateID);
    const rows = await db('Posts')
        .whereIn('CatID', childrenCateID)
        .orderBy([{ column: 'Premium', order: 'desc' }, { column: 'WriteTime', order: 'desc' }])
        .offset(offset)
    return rows;
}

/*
    Tim bai viet theo Category o Level 2 (thap) da public
*/
async function findByLevel2Category(IDcategory, offset) {
    let now = new Date();
    const rows = await db('Posts')
        .andWhere({
            CatID: IDcategory,
            StateID: 1
        })
        .andWhere('PubTime', '<=', now)
        .orderBy([{ column: 'Premium', order: 'desc' }, { column: 'PubTime', order: 'desc' }])
        .limit(postsLimit)
        .offset(offset)
    return rows;
}

/*
    Tim bai viet theo Category o Level 2 (thap)
*/
async function findAllByLevel2Category(IDcategory, offset) {
    const rows = await db('Posts')
        .where({
            CatID: IDcategory,
        })
        .orderBy([{ column: 'Premium', order: 'desc' }, { column: 'WriteTime', order: 'desc' }])
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

/*
    Tim bai viet mới nhất theo Category o Level 2 (thap)
*/
async function findNewPostByLevel2Category(IDcategory, limit, offset) {
    let now = new Date();
    const rows = await db('Posts')
        .where({
            CatID: IDcategory,
            StateID: 1,
        })
        .andWhere('PubTime', '<=', now)
        .orderBy('PubTime', 'desc')
        .limit(limit)
        .offset(offset)
    return rows;
}