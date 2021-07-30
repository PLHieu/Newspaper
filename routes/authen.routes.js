const authentication = require('../controllers/authen.controllers')
const authorMdw = require('../middlewares/authorUser.mdw')
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const FacebookStrategy = require('passport-facebook').Strategy;
const keys = require('../config/const.config');


passport.use(new GoogleStrategy({
    clientID: keys.googleClientID,
    clientSecret: keys.googleClientSecret,
    callbackURL: '/auth/google/callback'
    },
    authentication.passport_google
));

passport.use(new FacebookStrategy({
    clientID: keys.facebookClientID,
    clientSecret: keys.facebookClientSecret,
    callbackURL: 'http://localhost:3000/auth/facebook/callback'
    },
    authentication.passport_facebook
));


module.exports = function (app) {
    app.get('/auth/google',
    passport.authenticate('google', {
      scope: ['profile', 'email']
    }));

    app.get('/auth/google/callback', 
        passport.authenticate('google',{ 
        failureRedirect: '/failed',
        session: false }),async (req, res) => {
            const rows = await req.user;
            let role = "subcriber";
            authentication.login_successfully(role, rows, req, res,true);
        }
    );

    app.get('/auth/facebook',
    passport.authenticate('facebook', {
      scope: ['email']
    }));

    app.get('/auth/facebook/callback', 
        passport.authenticate('facebook',{ 
        failureRedirect: '/failed',
        session: false }),(req, res) => {//async
            res.redirect('/read/7')
            // const rows = await req.user;
            // let role = "subcriber";
            // authentication.login_successfully(role, rows, req, res,true);
        }
    );

    app.get('/failed', async (req, res) => { 
        res.status(404).render('404');
    })

    app.post('/saveRetURL', (req, res) => {
        req.session.retURL = req.body.retURL;
        console.log(req.session.retURL)
        res.json(true);
    })

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


