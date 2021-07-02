const categoryModel = require('../models/category.model');
const postsControl = require('../controllers/post.controllers')
module.exports = function (app) {

    app.use(async function (req, res, next) {
        
        const list= await postsControl.renderChild();
        res.locals.lcCategories  = list.cates;
        console.log(res.locals.lcCategories);
        next();
    })
}
