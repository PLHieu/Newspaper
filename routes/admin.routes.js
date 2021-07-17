const { adminPage } = require("../controllers/testuser.controllers");
const post_db = require('../models/post.model')
const cat_db = require('../models/category.model');
const tag_db = require('../models/tag.model');
const express = require('express');
const router = express.Router();

router.get('/user/manage', function(req, res) {
    return res.render('user/admin/quanlyuser')
});
router.get('/category/manage', function(req, res) {
    return res.render('user/admin/quanlycate')
});
router.get('/post/manage', async function(req, res) {
    const list_posts = await post_db.all();
    for (let i = 0; i < list_posts.length; i++) {
        list_posts[i] = await post_db.findPostByID(list_posts[i].ID);
    }
    return res.render('user/admin/quanlybaiviet',{
        list_posts
    })
});
router.get('/post/add', function(req, res) {
    return res.render('user/lib/form-baiviet')
});
router.get('/post/edit', async function(req, res) {
    id_post = req.query.postID;
    aPost = await post_db.findPostByID(id_post);
    //console.log(aPost);
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
    //console.log(list_tag);
    return res.render('user/writer/write_post',{
        postID: req.query.postID,
        category: aPost.CatID,
        title: aPost.Title,
        content: aPost.Content,
        abstract: aPost.Abstract,
        list_cat: list_cat,
        list_tag: list_tag,
    })
});
router.put('/post/edit', (req, res) => {
    //do sth after submit
    res.redirect('admin/post/manage');
})
router.get('/post/del', async function(req, res) {
    await post_db.delPost(req.query.postID);
    return res.redirect('/admin/post/manage');
});

router.get('/', function(req, res) {
    return res.redirect('/admin/manageuser')
});

module.exports = router;