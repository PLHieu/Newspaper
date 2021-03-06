const express = require('express');
const router = express.Router();
const posts_db = require('../models/post.model');
const writer_db = require('../models/writer.model');
const comments_db = require('../models/comment.model');
const moment = require('moment');

router.get('/:id', async function (req, res){
    id_post = req.params.id;
    post = await posts_db.findPostByID(id_post);
    console.log(post);
    if (post === null){
        return res.redirect('/failed');
    }
    for (let i = 0; i < post.comments.length; i++) {
        if (post.comments[i].ReaderID == null || req.session.user == null || 
            req.session.user.role!=post.comments[i].RoleReaderID || req.session.user.id!=post.comments[i].ReaderID) {
                post.comments[i].cantDelete = true;
        }
        else{
            post.comments[i].cantDelete = false;
        }
    }
    for (let i = 0; i < post.five_post_like_cat.length; i++){
        post.five_post_like_cat[i].PubTime = moment(post.five_post_like_cat[i].PubTime).format("DD/MM/YYYY");
        post.five_post_like_cat[i].Writer = await writer_db.findByID(post.five_post_like_cat[i].WriterID);
    }
    res.status(200).render('newspaper/detail_view',{
        post: post,
        //post_like_cat: five_post_like_cat
    });
});

router.post('/:id', async function (req, res){
    let readerID = null;
    let roleReaderId = null;
    if (res.locals.session.user !== null)
        readerID = req.session.user.id;
        roleReaderId = req.session.user.role;
    const new_comment = {
        ReaderID: readerID,
        PostID: req.params.id,
        PubTime: moment().format('YYYY/MM/DD'),
        Content: req.body.comment,
        RoleReaderID: roleReaderId,
    }
    await comments_db.addComment(new_comment);
    
    id_post = req.params.id;
    const post = await posts_db.findPostByID(id_post);
    console.log(post);
    if (post === null){
        return res.redirect('/failed');
    }
    for (let i = 0; i < post.five_post_like_cat.length; i++){
        post.five_post_like_cat[i].PubTime = moment(post.five_post_like_cat[i].PubTime).format("DD/MM/YYYY");
        post.five_post_like_cat[i].Writer = await writer_db.findByID(post.five_post_like_cat[i].WriterID);
    }
    res.status(200).render('newspaper/detail_view',{
        post: post,
    });
});

router.post('/:id/del-comment', async function(req, res){
    await comments_db.delComment(req.body.commentID);
    const url = `/read/${req.params.id}`;
    res.redirect(url);
})

router.post('/:id/edit-comment', async function(req, res){
    await comments_db.updateComment(req.query.id, req.body.new_content);
    const url = `/read/${req.query.params.id}`;
    res.redirect(url);
})
router.post('/download/:idpost', async function(req, res){
    let id_post = req.params.idpost;
    console.log(id_post);
    post = await posts_db.findPostByID(id_post)
    res.render('newspaper/printPost',{
        post: post,
    });
})

module.exports = router;