const categoryModel = require('../models/category.model');
const postsControl = require('../controllers/post.controllers')
const reader = require('../models/reader.model');
const writer = require('../models/writer.model');
const editor = require('../models/editor.model');
const moment = require('moment');
module.exports = function (app) {

    app.use( async function (req, res, next) {
        if (typeof (req.session.user)==='undefined'){
            req.session.user = null;
            res.locals.user = null;
        }
        else{
            if (req.session.user != null){
                console.log(req.session.user);
                if((req.session.user.subcriber)){
                    read = await reader.findByUsername(req.session.user.username);
                    if (read){
                        if (read.ExpTime){
                            req.session.user.premium = 1;
                            req.session.user.expTime =  moment(read.ExpTime).format('DD/MM/YYYY HH:mm:ss');
                        }else{
                            req.session.user.premium = 0;
                            req.session.user.expTime = null;
                        }
                        req.session.user.name =  read.Name;
                        req.session.user.address =  read.Address;
                        req.session.user.birthday =  moment(read.BirthDay).format('DD/MM/YYYY');
                        req.session.user.email =  read.Email;
                        res.locals.user = 1;
                        res.locals.session = req.session;
                    }
                }
                if((req.session.user.writer)){
                    wrt = await writer.findByUsername(req.session.user.username);
                    if (wrt){
                        req.session.user.name =  wrt.Name;
                        req.session.user.address =  wrt.Address;
                        req.session.user.birthday =  moment(wrt.BirthDay).format('DD/MM/YYYY');
                        req.session.user.email =  wrt.Email;
                        req.session.user.nickname =  wrt.NickName;
                        res.locals.user = 1;
                        res.locals.session = req.session;
                    }
                }
                if((req.session.user.editor)){
                    edt = await editor.findByUsername(req.session.user.username);
                    if (edt){
                        req.session.user.name =  edt.Name;
                        req.session.user.address =  edt.Address;
                        req.session.user.birthday =  moment(edt.BirthDay).format('DD/MM/YYYY');
                        req.session.user.email =  edt.Email;
                        res.locals.user = 1;
                        res.locals.session = req.session;
                    }
                }
                if((req.session.user.admin)){
                    res.locals.user = 1;
                    res.locals.session = req.session;
                }   
            }
        }
        res.locals.emailResetPass = null;
        res.locals.otp = null;
        next();
    })

    app.use(async function (req, res, next) {
        
        const list= await postsControl.renderChild();
        res.locals.lcCategories  = list.cates;
        //console.log(res.locals.lcCategories);
        next();
    })
}
