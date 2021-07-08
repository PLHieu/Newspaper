const express = require('express');
const knex = require('../utils/db');
const post_model = require('../models/post.model');
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
        const threshold = 0.2;
        for (var j = 0; j < add_posts.length; j++){
            if (add_posts[j].Score>threshold && !search_posts.some(el => el.ID === add_posts[j].ID))
                search_posts.push(add_posts[j]);
        }
    }
    const offset = 5;
    const page = parseInt(req.query.page) || 1;
    const start_post = (page-1)*offset;
    const end_post = start_post + offset;

    let list_posts = []
    for (var i = start_post; i < end_post && i <search_posts.length; i++){
        post = search_posts[i];
        post = await post_model.findPostByID(post.ID);
        list_posts.push(post);
    }
    const num_page =  parseInt(search_posts.length /offset) + 1;
    let list_page = [];
    for (let i = 1; i <= num_page; i++){
        list_page.push({'page':i, 'search_text':search_text})
    }
    console.log(search_posts.length, list_page);
    ;
    res.render('search',{ 
        list_posts,
        search_text,
        list_page,
        cur_page: page,
        prev_page: page==1? 1 :page-1, 
        next_page: page==num_page? num_page :page+1, 
    });
});


module.exports = router;