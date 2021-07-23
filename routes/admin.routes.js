const { adminPage } = require("../controllers/testuser.controllers");
const post_db = require('../models/post.model')
const cat_db = require('../models/category.model');
const tag_db = require('../models/tag.model');
const writer_db = require('../models/writer.model');
const posttag_db = require('../models/post_tag.model');
const adm_db = require('../models/admin.model');
const draft_db = require('../models/draft.model');
const reader_db = require('../models/reader.model');
const fs = require('fs');
var multer  = require('multer');
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');

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
};

function sorted_obj(obj) {
    let items = Object.keys(obj).map(function(key) {
        return [key, obj[key]];
    });
    items.sort(function(first, second) {
        return second[1] - first[1];
    });
    return items;
} 

router.get('/get-detail-post', async (req, res)=>{
    const detail_post = await post_db.findPostByID(req.query.postID);
    if (detail_post.StateID==-1){
        detail_post.draft = await draft_db.findByPostID(req.query.postID);
    }
    return res.json(detail_post);
})

router.get('/profile', (req,res) => {
    res.render('user/lib/profile')
});

router.post('/password', async function(req, res) {
    const rows_admin = await adm_db.findByID(req.session.user.id);
    const ret = bcrypt.compareSync(req.body.oldPassword, rows_admin.Password);
    const hash = bcrypt.hashSync(req.body.newPassword, 10);
    if(ret===true){
        await adm_db.changePassByID(hash, req.session.user.id);
        return res.status(200).send({ success: true});
    }
    else{
        return res.status(403).send({success: false});
    }
});

router.put('/profile',  async function(req,res){
    await adm_db.updateGeneralInfor(req.session.user.id, req.body.name, req.body.email, req.body.birthday, req.body.address );
    
    req.session.user.name = req.body.name;
    req.session.user.email = req.body.email;
    req.session.user.birthday = req.body.birthday;
    req.session.user.address = req.body.address;
    
    res.redirect('/admin/profile');
});

router.get('/user/manage', async function(req, res) {
    const list_reader_subPre = await reader_db.findListSubPremium();
    console.log(list_reader_subPre);
    return res.render('user/admin/quanlyuser', {
        subPremium: list_reader_subPre,
    })
});
router.get('/category/manage', function(req, res) {
    return res.render('user/admin/quanlycate')
});
router.get('/tag/manage', async function(req, res) {
    const list_tags = await tag_db.allTags();
    let dic_num_post_in_tag = {};
    for (let i = 0; i < list_tags.length; i++) {
        list_tags[i].num_posts = await posttag_db.countPostInTags(list_tags[i].ID);
        dic_num_post_in_tag[list_tags[i].ID] = list_tags[i].num_posts;
    }
    dic_num_post_in_tag = sorted_obj(dic_num_post_in_tag);
    console.log(dic_num_post_in_tag);
    return res.render('user/admin/quanlytag',{
        list_tags,
        dic_num_post_in_tag
    });
});
router.get('/post/manage', async function(req, res) {
    const all_posts = await post_db.all();
    const offset = 10;
    const page = parseInt(req.query.page) || 1;
    const start_post = (page - 1) * offset;
    const end_post = start_post + offset;
    let list_posts = []
    for (var i = start_post; i < end_post && i < all_posts.length; i++) {
        post = all_posts[i];
        post = await post_db.findPostByID(post.ID);
        list_posts.push(post);
    }
    const num_page = parseInt(all_posts.length / offset) + 1;
    let list_page = [];
    for (let i = 1; i <= num_page; i++) {
        list_page.push({ 'page': i , 'cur_page':page})
    }
    return res.render('user/admin/quanlybaiviet',{
        list_posts,
        list_page,
        cur_page: page,
        prev_page: page == 1 ? 1 : page - 1,
        next_page: page == num_page ? num_page : page + 1,
    })
});
router.get('/user/acceptsub', async function(req, res) {
    //await post_db.delPost(req.query.postID);
    console.log(req.query.userid);
    await reader_db.AcceptPremium(req.query.userid);
    return res.redirect('back');
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
    list_writer = await writer_db.findAll();
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
    for (let i=0; i<list_writer.length; i++){
        if (aPost.WriterID == list_writer[i].ID)
            list_writer[i].selected = true;
        else list_writer[i].selected = false;
    }
    //console.log(list_tag);
    return res.render('user/lib/form-baiviet',{
        postID: req.query.postID,
        category: aPost.CatID,
        title: aPost.Title,
        content: aPost.Content,
        abstract: aPost.Abstract,
        list_cat: list_cat,
        list_tag: list_tag,
        list_writer
    })
});
router.post('/post/edit', (req, res) => {
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
            const isDraft = await draft_db.findByPostID(postID);
            if (isDraft != null) {
                await draft_db.delete(postID);
            }
            await post_db.editPost(edit_post,postID);
            await posttag_db.del(postID);
            addPostTag(tag,postID);
            updateCoverPost(postID);
            res.redirect('/admin/post/manage');
        }
    });
});
router.post('/post/del', async function(req, res) {
    try{
        await post_db.delPost(req.body.postID);
    }catch(e){
        console.log(e);
        return res.status(500).send({deleted: false});
    }
    return res.status(200).send({deleted: true});
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