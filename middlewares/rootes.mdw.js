
const post =  require('../controllers/post.controllers')
module.exports = function (app) {
    app.get('/', post.RenderPost);
  }
  