const { editorPage } = require("../controllers/testuser.controllers");
const express = require('express');
const router = express.Router();
const post_db = require('../models/post.model');
const posttag_db = require('../models/post_tag.model');
const cat_db = require('../models/category.model');
const tag_db = require('../models/tag.model');
const draft_db = require('../models/draft.model');
const moment = require('moment');

router.get('/', editorPage)

router.get('/consider-a-post', async function (req, res){
    const PostID = req.query.postID;
    const post = await post_db.findByID(PostID);
    res.render('user/editor/view_post',{
        post
    })
})

router.get('/reject',(req, res) => {
    const PostID = req.query.postID;
    return res.render('user/editor/reject',{
        postID: PostID,
    })
})

router.post('/reject', async (req, res) => {
    const note = req.body.note_reject;
    const draft = {
        PostID: req.body.postID,
        EditorID: req.session.user.id,
        Note: note,
        RateTime: new Date(),
    }
    console.log(draft);
    const post = await post_db.findByID(req.body.postID);
    if (post.StateID == -2) {
        await draft_db.delete(req.body.postID);
    }
    await post_db.changeStateID(post.ID,-1);
    await draft_db.add(draft);
    return res.redirect('/editor');
})

router.get('/approve', async function (req, res) {
    const PostID = req.query.postID;
    const aPost = await post_db.findByID(PostID);
    list_cat = await cat_db.getAllChildren();
    list_tag = await tag_db.allTags();
    for (let i = 0; i < list_cat.length; i++) {
        if (aPost.CatID == list_cat[i].ID)
            list_cat[i].selected = true;
        else list_cat[i].selected = false;
    }
    for (let i = 0; i < list_tag.length; i++) {
        if (aPost.tags===null || !aPost.tags.some(el => el.ID === list_tag[i].ID))
            list_tag[i].selected = false;
        else list_tag[i].selected = true;
    }
    return res.render('user/editor/approve',{
        postID: PostID,
        list_tag,
        list_cat
    })
})

router.post('/approve', async function(req, res){
    const post = await post_db.findByID(req.body.postID);
    const pubTime = moment(req.body.raw_dfb,'DD/MM/YYYY').format('YYYY-MM-DD');
    const catID = req.body.category;
    const tags = req.body.tag;

    await post_db.changeStateID(post.ID,1);
    if (post.StateID == -2){
        await draft_db.delete(post.ID);
    }
    else{
        await post_db.updateApprovePost(post.ID,catID,pubTime);
    }

    await posttag_db.del(post.ID);
    for (let i = 0; i < tags.length; i++){
        const postTag = {
            PostID: post.ID,
            TagID: tags[i]
        }
        await posttag_db.add(postTag);
    }
    res.redirect('/editor');
})

module.exports = router;