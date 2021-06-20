const authentication = require('../controllers/authen.controllers')

module.exports = function (app) {
    app.get('/login', (req, res) => {
        res.render('login')
    })

    app.post('/login', authentication.signin);

    app.get('/signout', authentication.signout)

}