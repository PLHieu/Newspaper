const path = require('path');

function validRole(role, req, res, next){
    if (req.session.user.role != role) {
        res_str = `
        <p>You are ${req.session.user.role}</p>
        <h1>Require ${role} Role!</h1>
        `
        return res.status(403).send(res_str);
    }
    next();
}

exports.isAdmin = (req, res, next) => {
    if (req.session.user === null) {//chua dang nhap
        req.session.retURL = req.originalUrl;
        return res.redirect('/login');
    }
    validRole("admin", req, res, next);
}

exports.isWriter = async (req, res, next) => {
    if (req.session.user === null) {//chua dang nhap
        console.log('not login writer')
        req.session.retURL = req.originalUrl;
        return res.redirect('/login');
    }
    validRole("writer", req, res, next);
}

exports.isSubcriber = async (req, res, next) => {
    if (req.session.user === null) {//chua dang nhap
        req.session.retURL = req.originalUrl;
        return res.redirect('/login');
    }
    validRole("subcriber", req, res, next);
}

exports.isEditor = async (req, res, next) => {
    if (req.session.user === null) {//chua dang nhap
        req.session.retURL = req.originalUrl;
        return res.redirect('/login');
    }
    validRole("editor", req, res, next);
}

exports.checkAlreadyLoggedIn = (req, res, next) => {
    if (req.session.user != null) {
        // TODO: redirect cho tung role
        const url = req.session.retURL || '/'+req.session.user.role
        return res.redirect(url);
    }
    next();
}