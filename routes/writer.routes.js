const { writerPage } = require("../controllers/testuser.controllers");
const cat_db = require("../models/category.model")
const post_db = require("../models/post.model")
const tag_db = require("../models/tag.model")
const posttag_db = require("../models/post_tag.model")
const writer_db= require("../models/writer.model")
const express = require('express');
const moment = require('moment');
const { post } = require("./admin.routes");
const bcrypt = require('bcryptjs');
var multer  = require('multer');
const fs = require('fs');
const router = express.Router();



async function checkWriterAccessPostID(req, res, next){//
    const accessedWrtID = req.session.user.id;
    postID = req.query.postID;
    const post = await post_db.findPostByID(postID);
    const acceptedWrtID = post.WriterID;
    console.log(accessedWrtID, acceptedWrtID);
    if (accessedWrtID != acceptedWrtID){
        return res.status(403).send("You cannot access another's Post");
    }
    next();
}    

function updateCoverPost(postID){
    var oldPath = './public/image/posts/bigavt.jpg'
    var newPath = `./public/image/posts/${postID}/bigavt.jpg`
    fs.rename(oldPath, newPath, function (err) {
        if (err) throw err;
        else console.log('Successfully renamed - AKA moved!')
    })
    fs.copyFile(`./public/image/posts/${postID}/bigavt.jpg`, `./public/image/posts/${postID}/smallavt.jpg`, (err) => {
        if (err) throw err;
        else console.log(`bigavt was copied to smallavt`);
    });
}

async function addPostTag(tagslist,postID){
    for (let i =0; i < tagslist.length; i++) {
        let posttag = {
            PostID: postID,
            TagID: parseInt(tagslist[i]),
        }
        await posttag_db.add(posttag);
    }
}

async function addCatAndWriterNameInListPosts(list_posts, nameTime){
    for (var i = 0; i <list_posts.length; i++){
        list_posts[i].CatName = await cat_db.findNameCateByID(list_posts[i].CatID);
        list_posts[i][nameTime] = moment(list_posts[i][nameTime] ).format("DD/MM/YYYY HH:mm:ss");
    }
}

router.get('/', async function(req, res) {
    //const row = await writer_db(req.session.user.id);
    //butdanh = row[0].NickName;
    res.render('user/writer/profile',{
    });
})

router.get('/managepost', async function (req, res) {
    writerID = req.session.user.id;
    pending_posts_list = await post_db.findPendingPosts(writerID);
    addCatAndWriterNameInListPosts(pending_posts_list, 'WriteTime');
    rejected_posts_list = await post_db.findRejectedPosts(writerID);
    for (var i = 0; i <rejected_posts_list.length; i++){
        rejected_posts_list[i].CatName = await cat_db.findNameCateByID(rejected_posts_list[i].CatID);
        rejected_posts_list[i].draft_info.RateTime = moment(rejected_posts_list[i].draft_info.RateTime ).format("DD/MM/YYYY HH:mm:ss");
    }
    published_posts_list = await post_db.findPublishedPosts(writerID);
    addCatAndWriterNameInListPosts(published_posts_list,'PubTime');
    approved_not_publish_posts_list = await post_db.findApprovedNotPublishPosts(writerID);
    addCatAndWriterNameInListPosts(approved_not_publish_posts_list,'PubTime');
    // console.log(pending_posts_list);
    // console.log(rejected_posts_list);
    // console.log(published_posts_list);
    // console.log(approved_not_publish_posts_list);
    res.status(200).render('user/writer/main',{
        pending_posts_list,
        rejected_posts_list,
        published_posts_list,
        approved_not_publish_posts_list
    });
})

router.get('/write-post', async function(req, res) {
    list_cat = await cat_db.getAllChildren();
    list_tag = await tag_db.allTags();
    res.render('user/writer/write_post',{
        list_cat: list_cat,
        list_tag: list_tag,
        postID: -1
    });
})
router.get('/editprofile', async function(req, res) {
    res.render('user/writer/editprofile',{
    });
})
router.put('/profile', async function(req, res) {
    console.log(req.body.raw_dob);
    await writer_db.updateGeneralInfor(req.session.user.id, req.body.fullName, req.body.email, req.body.raw_dob, req.body.nickname );
    
    req.session.user.name = req.body.fullName;
    req.session.user.email = req.body.email;
    req.session.user.birthday = req.body.raw_dob;
    req.session.user.nickname = req.body.nickname;
    
    res.redirect('/writer');
    
})
router.put('/password', async function(req, res) {
    //req.session.user = null;
    //res.redirect('/');
    const rows_writer = await writer_db.findByID(req.session.user.id);
    const ret = bcrypt.compareSync(req.body.oldPassword, rows_writer.Password);
    const hash = bcrypt.hashSync(req.body.newPassword, 10);
    if(ret===true){
        await writer_db.changePassByID( hash, req.session.user.id);
        res.render('user/writer/profile');
    }
    else{
        return res.render('user/writer/editprofile', {
            err_message: 'Invalid password',
        })
    }
})

router.post('/write-post', async function(req, res) {
    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
          cb(null, `./public/image/posts/`);
        },
        filename: function (req, file, cb) {
          cb(null, 'bigavt.jpg');
        }
    })   
    const upload = multer({ storage: storage })
    upload.single('cover')(req, res, async function(err){
        if (err) console.log(err);
        else {
            //console.log(req.body);
            const {category, title, abstract, content, tag, postID} = req.body;
            //console.log(category, title, abstract, content, tag);
            const new_post = {
                Title: title,
                WriterID: req.session.user.id,
                CatID: category,
                StateID: 0,
                Content: content,
                Abstract: abstract,
                WriteTime: new Date(),
            }
            await post_db.addPost(new_post);
            just_post = await post_db.findPostByTitleWriter(new_post.Title, new_post.WriterID);
            addPostTag(tag, just_post.ID);

            const dir = `./public/image/posts/${just_post.ID}`
            if (fs.existsSync(dir)) {
                console.log('Directory exists!');
                fs.rmdirSync(dir, { recursive: false });
            }
            //crete folder save cover post
            fs.mkdir(`./public/image/posts/${just_post.ID}`, function(err) {
                if (err) {
                  console.log(err)
                } else {
                  console.log("New directory successfully created.")
                }
              })
            updateCoverPost(just_post.ID);
            res.redirect('/writer');
        }
    })
})

router.get('/post-detail',checkWriterAccessPostID, function(req, res){
    id_post = req.query.postID;
    res.render('user/writer/detail_post',{
        postID: id_post,
    })
})

router.get('/post-detail/edit',checkWriterAccessPostID,  async function(req, res){
    id_post = req.query.postID;
    aPost = await post_db.findPostByID(id_post);
    console.log(aPost);
    list_cat = await cat_db.getAllChildren();
    list_tag = await tag_db.allTags();
    for (let i = 0; i < list_cat.length; i++) {
        if (aPost.CatID == list_cat[i].ID)
            list_cat[i].selected = true;
        else list_cat[i].selected = false;
    }
    for (let i = 0; i < list_tag.length; i++) {
        if (aPost.tags===null || !aPost.tags.some(el => el.ID === list_tag[i].ID))
            list_tag[i].selected = false;
        else list_tag[i].selected = true;
    }
    console.log(list_tag);
    res.render('user/writer/write_post',{
        postID: req.query.postID,
        category: aPost.CatID,
        title: aPost.Title,
        content: aPost.Content,
        abstract: aPost.Abstract,
        list_cat: list_cat,
        list_tag: list_tag,
    })
})

router.post('/post-detail/edit', async function(req, res){
    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
          cb(null, `./public/image/posts/`);
        },
        filename: function (req, file, cb) {
          cb(null, 'bigavt.jpg');
        }
    })   
    const upload = multer({ storage: storage })
    upload.single('cover')(req, res, async function(err){
        if (err) console.log(err);
        else {
            const {category, title, abstract, content, tag, postID} = req.body;
            console.log(category, title, abstract, content, tag, postID);
            const edit_post = {
                Title: title,
                CatID: category,
                Content: content,
                Abstract: abstract,
            }
            await post_db.editPost(edit_post,postID);
            await posttag_db.del(postID);
            addPostTag(tag,postID);
            updateCoverPost(postID);
            res.redirect('/writer');
            }
    });
})

router.get('/is_duplicate_post', async function(req, res) {
    const title = req.query.title;
    const writerID = req.session.user.id;
    const postID = req.query.postID;
    const rows = await post_db.findPostByTitleWriter(title, writerID);
    if (rows === null || rows.ID==postID)
        return res.json(true);
    return res.json(false);
})

// router.get('/post-detail/del',checkWriterAccessPostID, function(req, res){
//     postID = req.query.postID;
//     await detail_view_db.delPost(postID);
// })

module.exports = router;