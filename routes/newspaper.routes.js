const express = require('express');
const router = express.Router();
const posts_db = require('../models/post.model');
const comments_db = require('../models/comment.model');
const moment = require('moment');

router.get('/:id', async function (req, res){
    id_post = req.params.id;
    post = await posts_db.findPostByID(id_post);
    for (let i = 0; i < post.comments.length; i++) {
        if (post.comments[i].ReaderID == null || req.session.user == null || 
            req.session.user.role!=post.comments[i].RoleReaderID || req.session.user.id!=post.comments[i].ReaderID) {
                post.comments[i].cantDelete = true;
        }
        else{
            post.comments[i].cantDelete = false;
        }
    }
    if (post === null){
        return res.status(404).send("Khong ton tai bai post");
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
router.post('/download/:idpost', async function(req, res){
    let id_post = req.params.idpost;
    console.log(id_post);
    post = await posts_db.findPostByID(id_post)
    res.render('newspaper/printPost',{
        post: post,
    });
})

module.exports = router;