const express = require('express');
const knex = require('../utils/db');
const router = express.Router();

router.get('/', async function(req, res){
    search_text = req.query.text_search;
    const query = `SELECT ID, MATCH (Title, Abstract,Content) AGAINST ('${search_text}' IN NATURAL LANGUAGE MODE) as Score FROM Posts ORDER BY Score desc;`;
    search_posts = await knex.raw(query);
    search_posts = search_posts[0];
    res.send(search_posts);
});


module.exports = router;