const authentication = require('../controllers/authen.controllers')
const authorMdw = require('../middlewares/authorUser.mdw')

module.exports = function (app) {
    app.get('/register',(req, res) => {
        res.render('account/register');
    })

    app.get('/is-available',authentication.is_available);
    app.get('/is-available-email',authentication.is_available_email);
    

    app.post('/register',authentication.register);

    app.get('/login', authorMdw.checkAlreadyLoggedIn, (req, res) => {
        after_register = req.query.register || null;
        res.render('account/login',{ 
            after_register: after_register
        })
    });

    app.post('/login', authentication.signin);

    app.get('/reset-password',(req, res)=>{
        res.render('account/reset_pass');
    });
    app.post('/reset-password',authentication.reset_password);

    app.get('/getOTP', function(req, res){
        console.log(req.query.noactive, req.query.register, req.query.email);
        const not_registered = req.query.register? false: true;
        const activeAccount = req.query.noactive? true: false;
        res.render('account/enter_otp',{
            not_registered,
            activeAccount,
            email: req.query.email
        });
    })
    app.post('/getOTP', authentication.handleReceiveOTP);

    app.post('/reset-password/resendOTP', authentication.resendOTP);

    app.get('/reset-password/changePassword', function(req, res){
        res.render('account/change_pass');
    })
    app.post('/reset-password/changePassword', authentication.changePasswordForgot);

    app.get('/signout', authentication.signout);
    /*app.get('/logout', function (req, res) {
        req.logout();
        res.redirect('/');
    });*/
    
}


