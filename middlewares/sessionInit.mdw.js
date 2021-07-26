const sessions = require('express-session')
const passport = require('passport')

module.exports = (app) => {
    app.set('trust proxy', 1);
    var expiryDate = new Date(Date.now() + 60 * 60 * 1000 * 2) // 2 hour
    app.use(sessions({
        secret: "thisismysecretkey",
        saveUninitialized: true,
        cookie: {expires: expiryDate},
        resave: false
    }));

    app.use(passport.initialize())
    // app.use(passport.session())

    
}