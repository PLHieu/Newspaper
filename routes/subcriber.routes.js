const express = require('express');
const sub_db = require('../models/reader.model');
const router = express.Router();

router.get('/', (req,res) => {
    res.redirect('/subcriber/profile')
});

router.get('/profile', (req,res) => {
    res.render('user/lib/profile')
});

router.put('/password', async function(req, res) {
    const rows_sub = await sub_db.findByID(req.session.user.id);
    const ret = bcrypt.compareSync(req.body.oldPassword, rows_sub.Password);
    const hash = bcrypt.hashSync(req.body.newPassword, 10);
    if(ret===true){
        await sub_db.changePass(req.session.user.id, hash);
        return res.status(200).send({login: true });
        res.render('user/subcriber/profile');
    }
    else{
        return res.status(403).send({login: false});
        return res.render('user/subcriber/editprofile', {
            err_message: 'Invalid password',
        })
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