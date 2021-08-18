const express = require('express');
const sub_db = require('../models/reader.model');
const router = express.Router();
const bcrypt = require('bcryptjs');
const auth = require('../controllers/authen.controllers');
const moment = require('moment');
router.get('/', (req,res) => {
    res.redirect('/subcriber/profile')
});

router.get('/profile', async (req,res) => {
    res.render('user/lib/profile')
});

router.post('/subPremium',  async function(req, res) {
    await sub_db.subPremium(1, req.session.user.id);
    req.session.user.subPremium = 1;
    //window.alert('đăng ký thành công, đợi admin duyệt');
    res.redirect('back');
});

router.post('/password', async function(req, res) {
    const rows_sub = await sub_db.findByID(req.session.user.id);
    const ret = bcrypt.compareSync(req.body.oldPassword, rows_sub.Password);
    const hash = bcrypt.hashSync(req.body.newPassword, 10);
    if(ret===true){
        await sub_db.changePass(req.session.user.id, hash);
        return res.status(200).send({success: true});
    }
    else{
        return res.status(403).send({ success: false});
    }
});

router.put('/profile',  async function(req,res){
    await sub_db.updateGeneralInfor(req.session.user.id, req.body.name, req.body.email, req.body.birthday, req.body.address );
    
    req.session.user.name = req.body.name;
    req.session.user.email = req.body.email;
    req.session.user.birthday = req.body.birthday;
    req.session.user.address = req.body.address;
    
    res.redirect('/subcriber/profile');
});
module.exports = router;