const { adminPage } = require("../controllers/testuser.controllers");
const post_db = require('../models/post.model')
const cat_db = require('../models/category.model');
const tag_db = require('../models/tag.model');
const writer_db = require('../models/writer.model');
const posttag_db = require('../models/post_tag.model');
const adm_db = require('../models/admin.model');
const draft_db = require('../models/draft.model');
const reader_db = require('../models/reader.model');
const editor_db = require('../models/editor.model');
const fs = require('fs');
var multer  = require('multer');
const moment = require('moment');
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const { writer } = require("repl");
const { now } = require("moment");
const { post } = require("./post.routes");

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
    const n_commonTag = 15;
    let items = Object.keys(obj).map(function(key) {
        return [key, obj[key]];
    });
    items.sort(function(first, second) {
        return second[1] - first[1];
    });
    return items.slice(0, n_commonTag);
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
    //console.log(list_reader_subPre);
    const list_reader = await reader_db.findAll();
    const list_editor = await editor_db.allEditor();
    const list_writer = await writer_db.findAll();
    var sublen = list_reader_subPre.length;
    //console.log(list_reader);
    return res.render('user/admin/quanlyuser', {
        subPremium: list_reader_subPre,
        sublen,
        editor: list_editor,
        writer: list_writer,
        subcriber: list_reader,
    })
});
router.get('/category/manage', async function(req, res) {
    const list_dad = await cat_db.findDadCategories();
    //const num_tags = list_tags.length;
    //let dic_num_post_in_tag = {};
    let result = [], numchild = 0, numdad = 0, duyetdad = 0, chuaduyetdad = 0, tuchoidad = 0;
    let duyetchild = 0, chuaduyetchild = 0, tuchoichild = 0;
    console.log(list_dad);
    for (let i = 0; i < list_dad.length; i++) {
        //let des = objectMapper(dad[i], rule1)
        //console.log(des);
        duyetdad = await post_db.countAcceptPostByCategory(list_dad[i].ID);
        chuaduyetdad = await post_db.countChuaDuyetPostByCategory(list_dad[i].ID);
        tuchoidad = await post_db.countRefusePostByCategory(list_dad[i].ID);
        numdad = tuchoidad + chuaduyetdad + duyetdad;
        const child = await cat_db.findChildCategories(list_dad[i].ID)
        for (let j =0; j<child.length; j++){
            duyetchild = await post_db.countAcceptPostByCategory(child[j].ID);
            chuaduyetchild = await post_db.countChuaDuyetPostByCategory(child[j].ID);
            tuchoichild = await post_db.countRefusePostByCategory(child[j].ID);
            numchild = duyetchild + chuaduyetchild + tuchoichild;
            child[j].numpost = numchild;
            child[j].accept = duyetchild;
            child[j].refuse = tuchoichild;
            child[j].chuaduyet = chuaduyetchild;
            numdad+=numchild;
            duyetdad+=duyetchild;
            chuaduyetdad+= chuaduyetchild;
            tuchoidad+=tuchoichild;
        }
        list_dad[i].child = child;
        list_dad[i].numpost = numdad;
        list_dad[i].accept = duyetdad;
        list_dad[i].refuse = tuchoidad;
        list_dad[i].chuaduyet = chuaduyetdad;
        result.push(list_dad[i]);
    }
    //console.log(result1[0]);
    //console.log(result);
    console.log(list_dad);
    
    return res.render('user/admin/quanlycate',{
        list_dad,
    });
});

router.get('/category/existed-cate', async function (req, res){
    if(req.query.catid){
        const cat = await cat_db.findCateByID(req.query.catid);
        if(cat.Name == req.query.catName){
            return res.json(false);
        }
    }
    const cate = await cat_db.findByCateName(req.query.catName);
    if (cate === null)
        return res.json(false);
    return res.json(true);
})
router.get('/category/edit', async function (req, res){
    
    const cateName = req.query.catName;
    const cateID = req.query.catID;
    console.log(req.query);
    const cat = await cat_db.findCateByID(cateID);
    console.log(cat);
    let isDad = 1;
    const list_dad = await cat_db.findDadCategories();
    for (i = 0; i < list_dad.length ; i++){
        list_dad[i].selected = false;
    }
    if (cat.ParentID != null){
        //list_dad[cat.ParentID] = true;
        isDad = null;
        for (i = 0; i < list_dad.length ; i++){
            if(list_dad[i].ID == cat.ParentID){
                list_dad[i].selected = true;
            }
            else{
                list_dad[i].selected = false;
            }
        }
    }else{
        let flag = 0;
        for (i = 0; i < list_dad.length ; i++){
            if(list_dad[i].ID == cateID){
                flag = i;
            }
            list_dad[i].selected = false;
        }
        list_dad.splice(flag, 1);
    }
    console.log(list_dad);
    res.render('user/lib/edit-cate-admin', {
        cateName,
        cateID,
        list_dad,
        isDad,
    })
})
router.post('/category/edit', async function(req, res){
    console.log(req.body);
    await cat_db.updateCategory(req.query.cateid, req.body.name, req.body.category );
    res.redirect('/admin/category/manage');
})
router.post('/category/add', async function(req, res){
    await cat_db.add(req.body.cat_name, req.body.category);
    //console.log(req.body);
    res.json(`Bạn đã thêm tag <b>${req.body.cat_name}</b> thành công.`);
})
router.post('/category/del', async function(req, res){
    try{
        await cat_db.del(req.body.catID);
    }catch(e){
        console.log(e);
        return res.status(500).send({deleted: false});
    }
    return res.status(200).send({deleted: true});
})
router.get('/tag/manage', async function(req, res) {
    const list_tags = await tag_db.allTags();
    const num_tags = list_tags.length;
    let dic_num_post_in_tag = {};
    for (let i = 0; i < list_tags.length; i++) {
        list_tags[i].num_posts = await posttag_db.countPostInTags(list_tags[i].ID);
        dic_num_post_in_tag[list_tags[i].Name] = list_tags[i].num_posts;
    }
    dic_num_post_in_tag = sorted_obj(dic_num_post_in_tag);
    //console.log(dic_num_post_in_tag);
    let label_chart = [];
    let data_chart = [];
    for (let i = 0; i < dic_num_post_in_tag.length; i++){
        label_chart.push(dic_num_post_in_tag[i][0])
        data_chart.push(dic_num_post_in_tag[i][1])
    }
    //console.log(data_chart)
    return res.render('user/admin/quanlytag',{
        list_tags,
        label_chart,
        data_chart,
        num_tags
    });
});
router.post('/tag/add', async function(req, res){
    await tag_db.add(req.body.tag_name);
    res.json(`Bạn đã thêm tag <b>${req.body.tag_name}</b> thành công.`);
})
router.get('/tag/existed-tag', async function (req, res){
    const tag = await tag_db.findByTagName(req.query.tagName);
    if (tag === null)
        return res.json(false);
    return res.json(true);
})
router.get('/tag/del', async function(req, res){
    await tag_db.del(req.query.tagID);
    return res.redirect('/admin/tag/manage');
})

router.get('/post/manage', async function(req, res) {
    let all_posts = null;
    const tag_name = req.query.tagName || null;
    const cat_name = req.query.catName || null;
    if (req.query.catID){
        all_posts = await post_db.findByCategory(req.query.catID, 0);
        
    }
    else{
        
        if (req.query.tagID){
            all_posts = await posttag_db.findPostByTagID(req.query.tagID);
            for (let i = 0; i < all_posts.length; i++) {
                all_posts[i] = await post_db.findPostByID(all_posts[i].PostID);
            }
        }
        else all_posts = await post_db.all();
    } 
    const offset = 10;
    const page = parseInt(req.query.page) || 1;
    const start_post = (page - 1) * offset;
    const end_post = start_post + offset;
    let list_posts = [];
    for (var i = start_post; i < end_post && i < all_posts.length; i++) {
        lpost = all_posts[i];
        lpost = await post_db.findPostByID(lpost.ID);
        list_posts.push(lpost);
    }
    const num_page = parseInt(all_posts.length / offset) + 1;
    let list_page = [];
    for (let i = 1; i <= num_page; i++) {
        list_page.push({ 'page': i , 'cur_page':page})
    }
    return res.render('user/admin/quanlybaiviet',{
        tag_name,
        cat_name,
        list_posts,
        list_page,
        cur_page: page,
        prev_page: page == 1 ? 1 : page - 1,
        next_page: page == num_page ? num_page : page + 1,
    })
});
router.get('/user/acceptsub', async function(req, res) {
    await reader_db.AcceptPremium(req.query.userid);
    return res.redirect('back');
});
router.get('/user/cancelpremium', async function(req, res) {
    try{
        await reader_db.CancelPremium(req.query.userid);
    }catch(e){
        console.log(e);
        return res.status(500).send({deleted: false});
    }
    return res.status(200).send({deleted: true});
});
router.get('/getinforsubcriber', async function(req, res) {
    let reader = await reader_db.findByID(req.query.userid);
    reader.BirthDay = moment(reader.BirthDay).format('DD/MM/YYYY');
    return res.json(reader);
});
router.get('/getinforeditor', async function(req, res) {
    console.log(req.query.userid);
    let editor = await editor_db.findByID(req.query.userid);
    let catename = await cat_db.getCategory(editor.CatID);
    editor.CateName = catename.Name;
    editor.BirthDay = moment(editor.BirthDay).format('DD/MM/YYYY');
    //console.log(editor);
    return res.json(editor);
});
router.get('/getinforwriter', async function(req, res) {
    console.log(req.query.userid);
    let writer = await writer_db.findByID(req.query.userid);
    writer.BirthDay = moment(writer.BirthDay).format('DD/MM/YYYY');
    console.log(writer);
    return res.json(writer);
});
router.get('/user/edit/writer', async function(req, res){
    id_user = req.query.userid;
    user = await writer_db.findByID(id_user);
    user.BirthDay = moment(user.BirthDay).format('DD/MM/YYYY');
    user.writer = 1;
    user.editor = null;
    user.sub = null;
    //console.log(aPost);
    return res.render('user/lib/edit-profile-admin',{
        user: user,
    })
})
router.get('/user/edit/editor', async function(req, res){
    id_user = req.query.userid;
    user = await editor_db.findByID(id_user);
    let catename = await cat_db.getCategory(user.CatID);
    user.BirthDay = moment(user.BirthDay).format('DD/MM/YYYY');
    user.CateName = catename.Name;
    //console.log(editor);
    user.writer = null;
    user.editor = 1;
    user.sub = null;
    list_cat = await cat_db.all();
    //list_tag = await tag_db.allTags();
    //list_writer = await writer_db.findAll();
    for (let i = 0; i < list_cat.length; i++) {
        if (user.CatID == list_cat[i].ID)
            list_cat[i].selected = true;
        else list_cat[i].selected = false;
    }
    //console.log(aPost);
    return res.render('user/lib/edit-profile-admin',{
        user: user,
        list_cat,
    })
})
router.get('/user/edit/subcriber', async function(req, res){
    id_user = req.query.userid;
    user = await reader_db.findByID(id_user);
    if(user.ExpTime){
        
    user.ExpTime = moment(user.ExpTime).format('DD/MM/YYYY, HH:MM:SS');
    }
    user.BirthDay = moment(user.BirthDay).format('DD/MM/YYYY');
    user.writer = null;
    user.editor = null;
    user.sub = 1;
    console.log(user);
    return res.render('user/lib/edit-profile-admin',{
        user: user,
    })
})
router.post('/user/edit/subcriber', async function(req, res){
    await reader_db.updateGeneralInfor(req.query.userid, req.body.name, req.body.email, req.body.birthday, req.body.address );
    
    res.status(200).redirect('back');
})
router.post('/user/edit/editor', async function(req, res){
    await editor_db.updateGeneralInfor(req.query.userid, req.body.name, req.body.email, req.body.birthday, req.body.address, req.body.category );
    
    res.status(200).redirect('back');
})
router.post('/user/edit/writer', async function(req, res){
    await writer_db.updateGeneralInfor(req.query.userid, req.body.name, req.body.email, req.body.birthday, req.body.address,req.body.nickname );
    
    res.status(200).redirect('back');
})
router.post('/user/reset/subcriber', async function(req, res){
    try{
        content = 'subcriber';
        const hash = bcrypt.hashSync(content, 10);
        await reader_db.changePassByID(hash,req.query.userid);
    }catch(e){
        console.log(e);
        return res.status(500).redirect('back');
    }
    return res.status(200).redirect('back');
})
router.post('/user/reset/editor', async function(req, res){
    try{
        content = 'editor';
        const hash = bcrypt.hashSync(content, 10);
        await editor_db.changePassByID(hash,req.query.userid);
    }catch(e){
        console.log(e);
        return res.status(500).redirect('back');
    }
    return res.status(200).redirect('back');
   
})
router.post('/user/reset/writer', async function(req, res){
    try{
        content = 'writer';
        const hash = bcrypt.hashSync(content, 10);
        await writer_db.changePassByID(hash,req.query.userid);
    }catch(e){
        console.log(e);
        return res.status(500).redirect('back');
    }
    return res.status(200).redirect('back');
   
})

router.get('/user/addeditor', async function(req, res) {
    list_cat = await cat_db.getAllChildren();
    editor = 1;
    role = 'Editor';
    res.render('user/lib/form-regist-admin',{
        list_cat,
        editor,
        role,
    });
});
router.get('/user/addsubcriber', async function(req, res) {
    subcriber = 1;
    role = 'Subcriber';
    res.render('user/lib/form-regist-admin',{
        subcriber,
        role,
    });
});
router.get('/user/addwriter', async function(req, res) {
    wrt = 1;
    role = 'Writer';
    res.render('user/lib/form-regist-admin',{
        writer: wrt,
        role,
    });
});
router.post('/user/add/editor', async function (req, res) {
    let dob = req.body.birthday.slice(6) + '-' + req.body.birthday.slice(3,5) + '-' + req.body.birthday.slice(0,2);
    console.log(req.body);
    const hash = bcrypt.hashSync('editor', 10);
    const user = {
        UserName: req.body.username,
        Password: hash,
        BirthDay: dob,
        Name: req.body.name,
        Email: req.body.email,
        Address: req.body.address,
        CatID: req.body.category,
    }
    await editor_db.add(user);
    return res.redirect('back');
})
router.post('/user/add/writer', async function (req, res) {
    console.log(req.body);
    let dob = req.body.birthday.slice(6) + '-' + req.body.birthday.slice(3,5) + '-' + req.body.birthday.slice(0,2);
    const hash = bcrypt.hashSync('writer', 10);
    const user = {
        UserName: req.body.username,
        Password: hash,
        NickName: req.body.nickname,
        BirthDay: dob,
        Name: req.body.name,
        Email: req.body.email,
        Address: req.body.address,
        Active: 1,
    }
    await writer_db.add(user);
    return res.redirect('back');
})
router.post('/user/add/subcriber', async function (req, res) {
    console.log(req.body);
    let dob = req.body.birthday.slice(6) + '-' + req.body.birthday.slice(3,5) + '-' + req.body.birthday.slice(0,2);
    const hash = bcrypt.hashSync('subcriber', 10);
    let date = new Date();
    let datetime = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' +date.getDate() + ' ' + date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds();
    //console.log(datetime);
    if (req.body.premium == '0'){
        datetime = null;
    }
    const user = {
        UserName: req.body.username,
        Password: hash,
        BirthDay: dob,
        Name: req.body.name,
        Email: req.body.email,
        Address: req.body.address,
        ExpTime: datetime,
        OTP: -1
    }
    await reader_db.add(user);
    return res.redirect('back');
})
router.post('/user/delete/subcriber', async function(req, res) {
    try{
        await reader_db.delUser(req.body.userid);
    }catch(e){
        console.log(e);
        return res.status(500).send({deleted: false});
    }
    return res.status(200).send({deleted: true});
});
router.post('/user/delete/editor', async function(req, res) {
    try{
        await editor_db.delUser(req.body.userid);
    }catch(e){
        console.log(e);
        return res.status(500).send({deleted: false});
    }
    return res.status(200).send({deleted: true});
});
router.post('/user/delete/writer', async function(req, res) {
    try{
        await writer_db.delUser(req.body.userid);
    }catch(e){
        console.log(e);
        return res.status(500).send({deleted: false});
    }
    return res.status(200).send({deleted: true});
});
router.get('/post/del', async function(req, res) {
    await post_db.delPost(req.query.postID);
    return res.redirect('/admin/post/manage');
});
router.get('/post/del', async function(req, res) {
    await post_db.delPost(req.query.postID);
    return res.redirect('/admin/post/manage');
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
    return res.redirect('/admin/user/manage')
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