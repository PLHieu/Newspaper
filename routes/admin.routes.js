const { adminPage } = require("../controllers/testuser.controllers");
const express = require('express');
const router = express.Router();

router.get('/manageuser', function(req, res){
    return res.render('user/admin/quanlyuser')
});
router.get('/managecategory', function(req, res){
    return res.render('user/admin/quanlycate')
});
router.get('/managepost', function(req, res){
    return res.render('user/admin/quanlybaiviet')
});
router.get('/', function(req, res){
    return res.redirect('/admin/manageuser')
});

module.exports = router;