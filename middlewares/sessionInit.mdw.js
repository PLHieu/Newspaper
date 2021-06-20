const sessions = require('express-session')

module.exports = (app) => {
    app.set('trust proxy', 1);
    var expiryDate = new Date(Date.now() + 60 * 60 * 1000) // 1 hour
    app.use(sessions({
        secret: "thisismysecretkey",
        saveUninitialized: true,
        cookie: {expires: expiryDate},
        resave: false
    }));
}