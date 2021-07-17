const { adminPage } = require("../controllers/testuser.controllers");
const post_db = require('../models/post.model')
const cat_db = require('../models/category.model');
const tag_db = require('../models/tag.model');
const writer_db = require('../models/writer.model');
const posttag_db = require('../models/post_tag.model');
const fs = require('fs');
var multer  = require('multer');
const express = require('express');
const router = express.Router();


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


router.get('/user/manage', function(req, res) {
    return res.render('user/admin/quanlyuser')
});
router.get('/category/manage', function(req, res) {
    return res.render('user/admin/quanlycate')
});
router.get('/post/manage', async function(req, res) {
    const list_posts = await post_db.all();
    for (let i = 0; i < list_posts.length; i++) {
        list_posts[i] = await post_db.findPostByID(list_posts[i].ID);
    }
    return res.render('user/admin/quanlybaiviet',{
        list_posts
    })
});
router.get('/post/add', async function(req, res) {
    list_cat = await cat_db.getAllChildren();
    list_tag = await tag_db.allTags();
    list_writer = await writer_db.findAll();
    res.render('user/lib/form-baiviet',{
        list_cat,
        list_tag,
        list_writer,
        postID: -1
    });
});
router.post('/post/add', async function(req, res){
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
            const {category, title, abstract, content, tag, postID, writerID} = req.body;
            //console.log(category, title, abstract, content, tag);
            const new_post = {
                Title: title,
                WriterID: writerID,
                CatID: category,
                StateID: 1,
                Content: content,
                Abstract: abstract,
                WriteTime: new Date(),
                PubTime: new Date(),
            }
            await post_db.addPost(new_post);
            just_post = await post_db.findPostByTitleWriter(new_post.Title, new_post.WriterID);
            await addPostTag(tag, just_post.ID);

            const dir = `./public/image/posts/${just_post.ID}`
            await fs.access(dir, fs.constants.F_OK, async (err) => {
                console.log(`${dir} ${err ? 'does not exist' : 'exists'}`);
                if (!err) {
                    await fs.rmdirSync(dir, { recursive: true });
                }
                //crete folder save cover post
                await fs.mkdir(`./public/image/posts/${just_post.ID}`, async function(err) {
                    if (err) {
                      console.log(err)
                    } else {
                        console.log("New directory successfully created.")
                      await updateCoverPost(just_post.ID);
                    }
                })
            });
            res.redirect('/admin/post/manage');
        }
    })
})
router.get('/post/edit', async function(req, res) {
    id_post = req.query.postID;
    aPost = await post_db.findPostByID(id_post);
    //console.log(aPost);
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
    //console.log(list_tag);
    return res.render('user/writer/write_post',{
        postID: req.query.postID,
        category: aPost.CatID,
        title: aPost.Title,
        content: aPost.Content,
        abstract: aPost.Abstract,
        list_cat: list_cat,
        list_tag: list_tag,
    })
});
router.put('/post/edit', (req, res) => {
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
                StateID: 1,
                PubTime: new Date()
            }
            await post_db.editPost(edit_post,postID);
            await posttag_db.del(postID);
            addPostTag(tag,postID);
            updateCoverPost(postID);
            res.redirect('/admin/post/manage');
        }
    });
});
router.get('/post/del', async function(req, res) {
    await post_db.delPost(req.query.postID);
    return res.redirect('/admin/post/manage');
});

router.get('/', function(req, res) {
    return res.redirect('/admin/manageuser')
});

router.get('/post/is_duplicate_post', async function(req, res) {
    const title = req.query.title;
    const writerID = req.query.writerID;
    const postID = req.query.postID;
    const rows = await post_db.findPostByTitleWriter(title, writerID);
    if (rows === null || rows.ID==postID)
        return res.json(true);
    return res.json(false);
})

module.exports = router;