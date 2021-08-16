post_db = require('../models/post.model')
editor_db = require('../models/editor.model')

exports.guestPage = (req, res) => {
    res.status(200).render("home2");
};

exports.editorPage = async (req, res) => {
    editor_id = req.session.user.id;
    editor = await editor_db.findByID(editor_id);
    draft_posts = await post_db.findDraftPostsByCatID(editor.CatID);
    rejected_posts = await post_db.findRejectedPostsByEditor(editor_id);
    approved_posts = await post_db.findApprovedPostsByEditor(editor_id);
    res.status(200).render("user/editor/main", {
        draft_posts,
        rejected_posts,
        approved_posts,
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
