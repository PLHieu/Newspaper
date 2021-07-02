const express = require('express');
const knex = require('../utils/db');
const post_model = require('../models/detail_view.model');
const router = express.Router();

router.get('/', async function(req, res){
    search_text = req.query.text_search;
    const query = `SELECT ID, MATCH (Title, Abstract,Content) AGAINST ('${search_text}' IN NATURAL LANGUAGE MODE) as Score FROM Posts ORDER BY Score desc;`;
    search_posts = await knex.raw(query);
    search_posts = search_posts[0];
    for (var i = 0; i < search_posts.length; i++){
        post = search_posts[i];
        post = await post_model.findPostByID(post.ID);
        search_posts[i] = post;
    }
    console.log(search_posts[0]);
    res.render('search',{ 
        list_posts: search_posts,
        title: "Search"
    });
});


module.exports = router;