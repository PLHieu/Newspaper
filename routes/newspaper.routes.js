const express = require('express');
const router = express.Router();
const posts_db = require('../models/detail_view.model');
const post_cat_tag_db = require('../models/post.model');
const moment = require('moment');

router.get('/:id', async function (req, res){
    id_post = req.params.id;
    post = await posts_db.findPostByID(id_post);
    comments = await posts_db.findCommentByID(id_post);
    if (post === null){
        return res.status(404).send("Khong ton tai bai post");
    }
    five_post_like_cat = await post_cat_tag_db.findByCategory(post.CatID, 5);
    for (let i = 0; i <five_post_like_cat.length; i++){
        p = five_post_like_cat[i];
        tags = await posts_db.findTagsByPostID(p.ID);
        five_post_like_cat[i].tags = tags;
    }
    console.log(five_post_like_cat[0]);
    res.status(200).render('newspaper/detail_view',{
        post: post,
        comments: comments,
        num_comments: comments.length,
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
    await posts_db.addComment(new_comment);
    
    id_post = req.params.id;
    post = await posts_db.findPostByID(id_post);
    comments = await posts_db.findCommentByID(id_post);
    if (post === null){
        return res.status(404).send("Khong ton tai bai post");
    }
    res.status(200).render('newspaper/detail_view',{
        post: post,
        comments: comments,
        num_comments: comments.length
    });
});

router.get('/:id/del-comment', async function(req, res){
    await posts_db.delComment(req.query.id);
    const url = `/read/${req.params.id}`;
    res.redirect(url);
})

router.post('/:id/edit-comment', async function(req, res){
    await posts_db.updateComment(req.query.id, req.body.new_content);
    const url = `/read/${req.query.params.id}`;
    res.redirect(url);
})


module.exports = router;