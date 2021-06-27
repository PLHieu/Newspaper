const express = require('express');
const router = express.Router();
const posts_db = require('../models/detail_view.model');
const moment = require('moment');

router.get('/read-a-newspaper', async function (req, res){
    id_post = req.query.id;
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

router.post('/read-a-newspaper', async function (req, res){
    const new_comment = {
        ReaderID: null,
        PostID: req.query.id,
        PubTime: moment().format('YYYY/MM/DD'),
        Content: req.body.comment
    }
    await posts_db.addComment(new_comment);
    
    id_post = req.query.id;
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



module.exports = router;