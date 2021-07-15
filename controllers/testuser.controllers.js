post_db = require('../models/post.model')
editor_db = require('../models/editor.model')

exports.guestPage = (req, res) => {
    res.status(200).render("home2");
};

exports.editorPage = async (req, res) => {
    editor_id = req.session.user.id;
    editor = await editor_db.findByID(editor_id);
    posts = await post_db.findDraftPostsByCatID(editor.CatID);
    res.status(200).render("user/editor/main", {
        posts
    });
};

exports.adminPage = (req, res) => {
    res.status(200).render("user/admin/quanlyuser");
};

exports.writerPage = (req, res) => {
    res.status(200).render("user/writer/main");
};

exports.SubcriberPage = (req, res) => {
    res.status(200).render("user/subcriber/profile");
};
