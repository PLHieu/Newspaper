const { writerPage } = require("../controllers/testuser.controllers");
const cat_db = require("../models/category.model")
const post_db = require("../models/post.model")
const tag_db = require("../models/tag.model")
const express = require('express');
const moment = require('moment');
const { post } = require("./admin.routes");
const router = express.Router();



async function checkWriterAccessPostID(req, res, next){//
    const accessedWrtID = req.session.user.id;
    postID = req.query.postID;
    const post = await post_db.findPostByID(postID);
    const acceptedWrtID = post.WriterID;
    console.log(accessedWrtID, acceptedWrtID);
    if (accessedWrtID != acceptedWrtID){
        return res.status(403).send("You cannot access another's Post");
    }
    next();
}    


router.get('/', async function (req, res) {
    list_posts = await post_db.findByWriterID(req.session.user.id);
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
    list_tag = await tag_db.allTags();
    res.render('user/writer/write_post',{
        list_cat: list_cat,
        list_tag: list_tag
    });
})

router.post('/write-post', async function(req, res) {
    const {category, title, abstract, content, tag} = req.body;
    //console.log(category, title, abstract, content);
    const new_post = {
        Title: title,
        WriterID: req.session.user.id,
        CatID: category,
        StateID: 0,
        Content: content,
        Abstract: abstract,
        WriteTime: new Date(),
    }
    await post_db.addPost(new_post);
    res.redirect('/writer');
})

router.get('/post-detail',checkWriterAccessPostID, function(req, res){
    id_post = req.query.postID;
    res.render('user/writer/detail_post',{
        postID: id_post,
    })
})

router.get('/post-detail/edit',checkWriterAccessPostID,  async function(req, res){
    id_post = req.query.postID;
    aPost = await post_db.findPostByID(id_post);
    console.log(aPost);
    list_cat = await cat_db.getAllChildren();
    list_tag = await tag_db.allTags();
    for (let i = 0; i < list_cat.length; i++) {
        if (aPost.CatID == list_cat[i].ID)
            list_cat[i].selected = true;
        else list_cat[i].selected = false;
    }
    for (let i = 0; i < list_tag.length; i++) {
        if (aPost.tags===null || aPost.tags.some(el => el.ID != list_tag[i].ID))
            list_tag[i].selected = false;
        else list_tag[i].selected = true;
    }
    console.log(list_tag);
    res.render('user/writer/write_post',{
        category: aPost.CatID,
        title: aPost.Title,
        content: aPost.Content,
        abstract: aPost.Abstract,
        list_cat: list_cat,
        list_tag: list_tag
    })
})

router.post('/post-detail/edit', async function(req, res){
    const {category, title, abstract, content, tag} = req.body;
    console.log(category, title, abstract, content);
    const edit_post = {
        Title: title,
        CatID: category,
        Content: content,
        Abstract: abstract,
    }
    await post_db.editPost(edit_post,req.query.postID);
    res.redirect('/writer');
})

// router.get('/post-detail/del',checkWriterAccessPostID, function(req, res){
//     postID = req.query.postID;
//     await detail_view_db.delPost(postID);
// })

module.exports = router;