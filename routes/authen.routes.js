const authentication = require('../controllers/authen.controllers')
const authorMdw = require('../middlewares/authorUser.mdw')

module.exports = function (app) {
    app.get('/register',(req, res) => {
        res.render('account/register');
    })

    app.get('/is-available',authentication.is_available);

    app.post('/register',authentication.register);

    app.get('/login', authorMdw.checkAlreadyLoggedIn, (req, res) => {
        after_register = req.query.register || null;
        console.log(after_register);
        res.render('account/login',{ 
            after_register: after_register
        })
    });

    app.post('/login', authentication.signin);

    app.get('/reset-password',authentication.reset_password);

    app.get('/signout', authentication.signout);
}


