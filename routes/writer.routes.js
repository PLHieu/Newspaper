const { writerPage } = require("../controllers/testuser.controllers");
const cat_db = require("../models/category.model")
const post_db = require("../models/post.model")
const detail_view_db = require("../models/detail_view.model")
const express = require('express');
const moment = require('moment');
const { post } = require("./admin.routes");
const router = express.Router();

router.get('/', async function (req, res) {
    console.log(req.session.user.id);
    list_posts = await post_db.findByWriterID(req.session.user.id);
    console.log(list_posts);
    for (var i = 0; i <list_posts.length; i++){
        list_posts[i].CatName = await cat_db.findNameCateByID(list_posts[i].CatID);
        list_posts[i].WriteTime = moment(list_posts[i].WriteTime).format("DD/MM/YYYY HH:mm:ss");
    }
    res.status(200).render('user/writer/main',{
        list_posts:list_posts
    });
})

router.get('/write-post', async function(req, res) {
    list_cat = await cat_db.getAllChildren();
    console.log(list_cat);
    res.render('user/writer/write_post',{
        list_cat: list_cat
    });
})

router.post('/write-post', function(req, res){
    const content = req.body.content;
    const abstract = req.body.abstract;
    console.log(content);
    console.log(abstract);
    res.redirect('/writer');
})

router.get('/detail-post', function(req, res){
    id_post = req.query.postID;
    res.render('user/writer/detail_post',{
        postID: id_post,
    })
})

router.get('/post-detail/edit', async function(req, res){
    id_post = req.query.postID;
    aPost = await detail_view_db.findPostByID(id_post);
    res.render('user/writer/write_post',{
        title: aPost.Title,
        content: aPost.Content,
        abstract:aPost.Abstract,
    })
})

router.get('/post-detail/del', function(req, res){
    res.send('Chua xu ly')
})

module.exports = router;