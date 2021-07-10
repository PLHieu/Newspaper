const { adminPage } = require("../controllers/testuser.controllers");
const express = require('express');
const router = express.Router();

router.get('/', adminPage);
router.get('/quanlycate', function(req, res){
    res.render('user/admin/quanlycate')
});

module.exports = router;