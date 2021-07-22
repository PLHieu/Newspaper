const express = require('express');
const post =  require('../controllers/post.controllers')
const router = express.Router();
const posts_db = require('../models/post.model');

router.get('/category/:id', post.getPostsByCategory);

router.get('/tag/:id', post.getPostsByTag)

router.get('/rest/:id',async (req, res)=> {
    id_post = req.params.id;
    detailed_post = await posts_db.findPostByID(id_post);
    if (detailed_post === null){
        return res.status(404).send("Khong ton tai bai post");
    }
    res.status(200).send(detailed_post);
})
module.exports = router