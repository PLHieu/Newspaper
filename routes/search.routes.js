const express = require('express');
const knex = require('../utils/db');
const post_model = require('../models/detail_view.model');
const router = express.Router();

router.get('/', async function(req, res){
    search_text = req.query.text_search;
    let search_posts = null;
    let query_title = null;
    if (search_text.length<=2){
        query_title = `SELECT ID FROM Posts WHERE Title LIKE ('%${search_text} %')`;
        search_posts = await knex.raw(query_title);
        search_posts = search_posts[0];
        query_AbsCon = `SELECT ID FROM Posts WHERE Abstract LIKE ('%${search_text} %') or Content LIKE ('%${search_text} %')`;
        add_posts = await knex.raw(query_AbsCon);
        add_posts = add_posts[0];
        for (var i = 0; i < add_posts.length; i++)
            if (!search_posts.some(el => el.ID === add_posts[i].ID))
                search_posts.push(add_posts[i]);
    }
    else {
        query_title = `SELECT ID, MATCH (Title) AGAINST ('${search_text}') as Score FROM Posts ORDER BY Score desc;`;
        search_posts = await knex.raw(query_title);
        search_posts = search_posts[0];
        for (var i = search_posts.length-1; i >= 0; i--){
            if (search_posts[i].Score===0)
                search_posts.splice(i, 1);
        }
        query_AbsCon = `SELECT ID, MATCH (Abstract, Content) AGAINST ('${search_text}') as Score FROM Posts ORDER BY Score desc;`;// WITH QUERY EXPANSION
        add_posts = await knex.raw(query_AbsCon);
        add_posts = add_posts[0];
        for (var j = 0; j < add_posts.length; j++){
            if (add_posts[j].Score>0.5 && !search_posts.some(el => el.ID === add_posts[j].ID))
                search_posts.push(add_posts[j]);
        }
    }
    for (var i = search_posts.length-1; i >= 0; i--){
        post = search_posts[i];
        post = await post_model.findPostByID(post.ID);
        search_posts[i] = post;
    }
    console.log(search_posts.length);
    res.render('search',{ 
        list_posts: search_posts,
        title: "Search"
    });
});


module.exports = router;