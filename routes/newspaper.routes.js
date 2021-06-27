const express = require('express');
const router = express.Router();
const posts_db = require('../models/detail_view.model');
const moment = require('moment');

router.get('/:id', async function (req, res){
    id_post = req.params.id;
    post = await posts_db.findPostByID(id_post);
    comments = await posts_db.findCommentByID(id_post);
    if (post === null){
        res.send("Khong ton tai bai post");
    }
    res.render('newspaper/detail_view',{
        post: post,
        comments: comments,
        num_comments: comments.length
    });
});

router.post('/:id', async function (req, res){
    const new_comment = {
        ReaderID: null,
        PostID: req.params.id,
        PubTime: moment().format('YYYY/MM/DD'),
        Content: req.body.comment
    }
    await posts_db.addComment(new_comment);
    
    id_post = req.params.id;
    post = await posts_db.findPostByID(id_post);
    comments = await posts_db.findCommentByID(id_post);
    if (post === null){
        res.send("Khong ton tai bai post");
    }
    res.render('newspaper/detail_view',{
        post: post,
        comments: comments,
        num_comments: comments.length
    });
});

router.get('/:id/del-comment', async function(req, res){
    await posts_db.delComment(req.query.id);
    const url = `/read/${req.query.params.id}`;
    res.redirect(url);
})

router.post('/:id/del-comment', async function(req, res){
    await posts_db.updateComment(req.query.id, req.body.new_content);
    const url = `/read/${req.query.params.id}`;
    res.redirect(url);
})



module.exports = router;