const categoryModel = require('../models/category.model');
const postsControl = require('../controllers/post.controllers')
const reader = require('../models/reader.model');
const moment = require('moment');
module.exports = function (app) {

    app.use( async function (req, res, next) {
        if (typeof (req.session.user)==='undefined'){
            req.session.user = null;
            res.locals.user = null;
        }
        else{
            if (req.session.user != null){
             
            if((req.session.user.subcriber)){
                //console.log('vao local');
                read = await reader.findByUsername(req.session.user.username);
                if (read){
                    if (read.ExpTime){
                        req.session.user.premium = 1;
                        req.session.user.expTime =  moment(read.ExpTime).format('DD/MM/YYYY HH:mm:ss');
                    }
                    res.locals.user = 1;
                    res.locals.session = req.session;
                    res.locals.session.premium = 1;
                }
            }
            else{
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
