const path = require('path');

exports.isAdmin = (req, res, next) => {
    if (req.session.user == null) {//chua dang nhap
        req.session.retURL = req.originalUrl;
        return res.redirect('/login');
    }
    if (req.session.user.role != "admin") {
        res_str = `
        <p>You are ${req.session.user.role}</p>
        <h1>Require Admin Role!</h1>
        `
        return res.status(403).send(res_str);
    }
    next();
}

exports.isWriter = async (req, res, next) => {
    if (req.session.user == null) {//chua dang nhap
        req.session.retURL = req.originalUrl;
        return res.redirect('/login');
    }
    if (req.session.user.role != "writer") {
        res_str = `
        <p>You are ${req.session.user.role}</p>
        <h1>Require Writer Role!</h1>
        `
        return res.status(403).send(res_str);
    }
    next();
}

exports.isSubcriber = async (req, res, next) => {
    if (req.session.user == null) {//chua dang nhap
        req.session.retURL = req.originalUrl;
        return res.redirect('/login');
    }
    if (req.session.user.role != "subcriber") {
        res_str = `
        <p>You are ${req.session.user.role}</p>
        <h1>Require Subcriber Role!</h1>
        `
        return res.status(403).send(res_str);
    }
    next();
}

exports.isEditor = async (req, res, next) => {
    if (req.session.user == null) {//chua dang nhap
        req.session.retURL = req.originalUrl;
        return res.redirect('/login');
    }
    if (req.session.user.role != "editor") {
        res_str = `
        <p>You are ${req.session.user.role}</p>
        <h1>Require Editor Role!</h1>
        `
        return res.status(403).send(res_str);
    }
    next();
}

exports.checkAlreadyLoggedIn = (req, res, next) => {
    if (req.session.user == null) {
        next();
        return;
    }

    if (req.session.user != null && req.session.user.logged) {
        // TODO: redirect cho tung role
        return res.redirect('/');
    }
}