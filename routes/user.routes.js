const controller = require('../controllers/testuser.controllers')
const authorMdw = require('../middlewares/authorUser.mdw')

module.exports = function (app) {
    app.use('/admin', authorMdw.isAdmin ,require('./admin.routes'))

    app.use('/writer',  authorMdw.isWriter, require('./writer.routes'))

    app.use('/subcriber',   authorMdw.isSubcriber , require('./subcriber.routes'))

    app.use('/editor',  authorMdw.isEditor, require('./editor.routes'))

    app.get('./guest' ,controller.guestPage)
}