const authentication = require('../controllers/authen.controllers')
const authorMdw = require('../middlewares/authorUser.mdw')

module.exports = function (app) {
    app.get('/login', authorMdw.checkAlreadyLoggedIn, (req, res) => {
        res.render('login')
    })

    app.post('/login', authentication.signin);

    app.get('/signout', authentication.signout)
}


