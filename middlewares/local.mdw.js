const categoryModel = require('../models/category.model');
const postsControl = require('../controllers/post.controllers')
module.exports = function (app) {

    app.use(function (req, res, next) {
        if (typeof (req.session.user)==='undefined'){
            req.session.user = null;
            res.locals.user = null;
        }
        else{
            res.locals.user = 1;
            res.locals.session = req.session;
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
