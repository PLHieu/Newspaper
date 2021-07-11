const { adminPage } = require("../controllers/testuser.controllers");
const express = require('express');
const router = express.Router();

router.get('/user/manage', function(req, res) {
    return res.render('user/admin/quanlyuser')
});
router.get('/category/manage', function(req, res) {
    return res.render('user/admin/quanlycate')
});
router.get('/post/manage', function(req, res) {
    return res.render('user/admin/quanlybaiviet')
});
router.get('/post/add', function(req, res) {
    return res.render('user/lib/form-baiviet')
});
router.get('/post/edit', function(req, res) {
    return res.render('user/lib/form-baiviet')
});
router.get('/', function(req, res) {
    return res.redirect('/admin/manageuser')
});

module.exports = router;