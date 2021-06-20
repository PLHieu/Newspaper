const controller = require('../controllers/testuser.controllers')
const authorMdw = require('../middlewares/authorUser.mdw')

module.exports = function (app) {
    app.get('/admin', authorMdw.isAdmin ,controller.adminPage)

    app.get('/writer',  authorMdw.isWriter, controller.writerPage)

    app.get('/subcriber',   authorMdw.isSubcriber , controller.SubcriberPage)

    app.get('/editor',  authorMdw.isEditor,controller.editorPage)

    app.get('./guest' ,controller.guestPage)
}