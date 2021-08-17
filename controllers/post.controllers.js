var objectMapper = require('object-mapper');
const moment = require('moment');
const { findByCategory, findTagsOfPost, findPostsByTag, countPostByCategory, countPostByTag, findHightlightByCategory, findHightlightPostsByTag, findTop10MostRead, findTop10New, findTop1PostPerCate, top3Post } = require("../models/post.model");
const { findDadCategories, findRelative, getTag, findChildCategories, findNameCateByID } = require('../models/category.model');
const { rule1, ruleCate, ruleTag } = require('../utils/mapper');
const { postsLimit } = require('../config/const.config');
const { findNameByID } = require('../models/writer.model');

module.exports = {

    async getPostsByCategory(req, res) {
        let IDcategory = req.params.id;
        let result = [];

        const limit = postsLimit;
        const page = req.query.page || 1;
        if (page < 1) page = 1;

        const currentNameCategory = await findNameCateByID(IDcategory);
        const currentCate = { ID: IDcategory, Name: currentNameCategory };

        const total = await countPostByCategory(IDcategory);
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
            des.TacGia = await findNameByID(des.WriterID)
            const tags = await findTagsOfPost(posts[i].ID)
            des.tags = tags;
            result.push(des)
        }

        const relative = await findRelative(IDcategory);

        // Tim danh sach cac Post noi bat cung chuyen muc        
        const hightlightPosts = await findHightlightByCategory(IDcategory, 5, 0);


        // console.log(relative);
        // console.log(page_numbers); ,
        return res.render('newspaper/categoried_posts', {
            posts: result,
            isDad: relative.isDad,
            Dad: relative.Dad,
            Children: relative.Children,
            currentCate,
            page_numbers,
            hightlightPosts
        });
    },

    async getPostsByTag(req, res) {
        let IDtag = req.params.id;

        const limit = postsLimit;
        const page = req.query.page || 1;
        if (page < 1) page = 1;

        const total = await countPostByTag(IDtag);
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
        let currentTag = await getTag(IDtag);
        let posts = await findPostsByTag(IDtag, offset);
        // console.log(currentTag);
        let result = [];
        for (let i = 0; i < posts.length; i++) {
            let des = objectMapper(posts[i], rule1)
            des.TacGia = await findNameByID(des.WriterID)
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
    },


    async renderChild(req, res) {

        let result1 = [];
        const dad = await findDadCategories();
        //console.log(dad);
        for (let i = 0; i < dad.length; i++) {
            let des = objectMapper(dad[i], rule1)
                //console.log(des);
            const child = await findChildCategories(dad[i].ID)
            des.Name = dad[i].Name;
            des.child = child;
            result1.push(des)
        }
        //console.log(result1[0]);
        //console.log(result1)
        return {
            cates: result1
        }
    },
    async RenderPost(req, res) {

        const top10MostRead = await findTop10MostRead();
        const top10New = await findTop10New()
        const listCate1Post = await findTop1PostPerCate();
        const list = await top3Post();
        let top3HighLightPost = [];
        let retop10MostRead = [];
        let retop10New = [];

        for (let i = 0; i < top10MostRead.length; i++) {
            top10MostRead[i].PubTime = moment(top10MostRead[i].PubTime).format("DD/MM/YYYY HH:mm:ss");
            let des = objectMapper(top10MostRead[i], rule1)
                //console.log(des);
            const nameCate = await findNameCateByID(top10MostRead[i].CatID)
                //console.log(nameCate);
            des.WriterID = top10MostRead[i].WriterID;
            des.CateID = top10MostRead[i].CatID;
            des.Views = top10MostRead[i].Views;
            des.CateName = nameCate;
            des.Premium = top10MostRead[i].Premium;
            retop10MostRead.push(des);
        }
        for (let i = 0; i < top10New.length; i++) {
            top10New[i].PubTime = moment(top10New[i].PubTime).format("DD/MM/YYYY HH:mm:ss");
            let des = objectMapper(top10New[i], rule1)
                //console.log(des);
            const nameCate = await findNameCateByID(top10New[i].CatID)
                //console.log(nameCate);
            des.WriterID = top10New[i].WriterID;
            des.CateID = top10New[i].CatID;
            des.Views = top10New[i].Views;
            des.CateName = nameCate;
            des.Premium = top10New[i].Premium;
            retop10New.push(des);
        }
        for (let i = 0; i < listCate1Post.length; i++) {
            listCate1Post[i].post.PubTime = moment(listCate1Post[i].post.PubTime).format("DD/MM/YYYY HH:mm:ss");
        }
        //console.log(listCate1Post[0].post.PubTime)

        for (let i = 0; i < list.length; i++) {
            list[i].PubTime = moment(list[i].PubTime).format("DD/MM/YYYY HH:mm:ss");
            let des = objectMapper(list[i], rule1)
                //console.log(des);
            const nameCate = await findNameCateByID(list[i].CatID)
                //console.log(nameCate);
            des.WriterID = list[i].WriterID;
            des.CateID = list[i].CatID;
            des.Views = list[i].Views;
            des.CateName = nameCate;
            des.Premium = list[i].Premium;
            top3HighLightPost.push(des);

        }
        //console.log(top3HighLightPost.length)
        return res.render('home2', {
            top10PostMostRead: retop10MostRead,
            top10PostNew: retop10New,
            listCate1Post: listCate1Post,
            top3HighLightPost: top3HighLightPost,
        });
    }


}