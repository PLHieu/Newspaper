const authentication = require('../controllers/authen.controllers')
const authorMdw = require('../middlewares/authorUser.mdw')

module.exports = function (app) {
    app.get('/register',(req, res) => {
        res.render('account/register');
    })

    app.get('/is-available',authentication.is_available);

    app.post('/register',authentication.register);

    app.get('/login', authorMdw.checkAlreadyLoggedIn, (req, res) => {
        res.render('account/login')
    });

    app.post('/login', authentication.signin);

    app.get('/signout', authentication.signout);
}


