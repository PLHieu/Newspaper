var objectMapper = require('object-mapper');
const { findByCategory, findTagsOfPost, findPostsByTag } = require("../models/post.model");
const { rule1 } = require('../utils/mapper');

module.exports = {

    async getPostsByCategory(req, res) {
        let IDcategory = req.params.id;
        let result = [];
        //TODO: offset
        const posts = await findByCategory(IDcategory);
        for (let i = 0; i < posts.length; i++) {
            let des = objectMapper(posts[i],rule1)
            const tags = await findTagsOfPost(posts[i].ID)
            des.tags = tags;
            result.push(des)
        }
        return res.status(200).send(result);
    },

    async getPostsByTag(req, res){
        let IDtag = req.params.id;
        // TODO: offset
        let posts = await findPostsByTag(IDtag);
        let result = [];
        for (let i = 0; i < posts.length; i++) {
            let des = objectMapper(posts[i],rule1)
            const tags = await findTagsOfPost(posts[i].ID)
            des.tags = tags;
            result.push(des)
        }
        return res.status(200).send(result);
    } 



}