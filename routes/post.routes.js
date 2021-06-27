const express = require('express');
const post =  require('../controllers/post.controllers')
const router = express.Router();

router.get('/category/:id', post.getPostsByCategory);

router.get('/tag/:id', post.getPostsByTag)
module.exports = router