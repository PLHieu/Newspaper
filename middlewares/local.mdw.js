const categoryModel = require('../models/category.model');
const postsControl = require('../controllers/post.controllers')
module.exports = function (app) {

    app.use(async function (req, res, next) {
        
        res.locals.lcCategories = await postsControl.renderChild();
        
        next();
    })
}
