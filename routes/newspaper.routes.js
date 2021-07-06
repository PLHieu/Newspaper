const express = require('express');
const router = express.Router();
const posts_db = require('../models/post.model');
const comments_db = require('../models/comment.model');
const moment = require('moment');

router.get('/:id', async function (req, res){
    id_post = req.params.id;
    post = await posts_db.findPostByID(id_post);
    if (post === null){
        return res.status(404).send("Khong ton tai bai post");
    }
    res.status(200).render('newspaper/detail_view',{
        post: post,
        //post_like_cat: five_post_like_cat
    });
});

router.post('/:id', async function (req, res){
    const new_comment = {
        ReaderID: null,
        PostID: req.params.id,
        PubTime: moment().format('YYYY/MM/DD'),
        Content: req.body.comment
    }
    await comments_db.addComment(new_comment);
    
    id_post = req.params.id;
    post = await posts_db.findPostByID(id_post);
    if (post === null){
        return res.status(404).send("Khong ton tai bai post");
    }
    res.status(200).render('newspaper/detail_view',{
        post: post,
    });
});

router.get('/:id/del-comment', async function(req, res){
    await comments_db.delComment(req.query.id);
    const url = `/read/${req.params.id}`;
    res.redirect(url);
})

router.post('/:id/edit-comment', async function(req, res){
    await comments_db.updateComment(req.query.id, req.body.new_content);
    const url = `/read/${req.query.params.id}`;
    res.redirect(url);
})


module.exports = router;