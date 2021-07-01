var objectMapper = require('object-mapper');
const { findByCategory, findTagsOfPost, findPostsByTag, countPostByCategory, countPostByTag, findHightlightByCategory, findHightlightPostsByTag } = require("../models/post.model");
const { findRelative, getTag } = require('../models/category.model');
const { rule1 } = require('../utils/mapper');
const { postsLimit } = require('../config/const.config');

module.exports = {

    async getPostsByCategory(req, res) {
        let IDcategory = req.params.id;
        let result = [];

        const limit = postsLimit;
        const page = req.query.page || 1;
        if (page < 1) page = 1;

        const total = await  countPostByCategory(IDcategory);
        // console.log(total);
        let nPages = Math.floor(total / limit);
        if (total % limit > 0) nPages++;

        const page_numbers = [];
        for (i = 1; i <= nPages; i++) {
            page_numbers.push({
                value: i,
                isCurrent: i === +page
            });
        }

        const offset = (page - 1) * limit;
        const posts = await findByCategory(IDcategory, offset);
        for (let i = 0; i < posts.length; i++) {
            let des = objectMapper(posts[i], rule1)
            const tags = await findTagsOfPost(posts[i].ID)
            des.tags = tags;
            result.push(des)
        }

        const relative = await findRelative(IDcategory);

        // Tim danh sach cac Post noi bat cung chuyen muc        
        const hightlightPosts = await findHightlightByCategory(IDcategory, 5, 0);


        // console.log(relative);
        // console.log(page_numbers);
        return res.render('newspaper/categoried_posts', {
            posts: result,
            isDad: relative.isDad,
            Dad: relative.Dad,
            Children: relative.Children,
            page_numbers,
            hightlightPosts
        });
    },

    async getPostsByTag(req, res) {
        let IDtag = req.params.id;

        const limit = postsLimit;
        const page = req.query.page || 1;
        if (page < 1) page = 1;

        const total = await  countPostByTag(IDtag);
        // console.log(total);
        let nPages = Math.floor(total / limit);
        if (total % limit > 0) nPages++;

        const page_numbers = [];
        for (i = 1; i <= nPages; i++) {
            page_numbers.push({
                value: i,
                isCurrent: i === +page
            });
        }

        const offset = (page - 1) * limit;
        let currentTag = await getTag(IDtag, offset);
        let posts = await findPostsByTag(IDtag);
        // console.log(posts);
        let result = [];
        for (let i = 0; i < posts.length; i++) {
            let des = objectMapper(posts[i], rule1)
            const tags = await findTagsOfPost(posts[i].ID)
            des.tags = tags;
            result.push(des)
        }
        // console.log(currentTag)

        // Tim danh sach cac Post noi bat cung tag       
        const hightlightPosts = await findHightlightPostsByTag(IDtag, 5, 0);

        return res.render('newspaper/tagged_posts', {
            posts: result,
            tagname: currentTag.Name,
            page_numbers,
            hightlightPosts
        });
    }



}