exports.isAdmin = (req, res, next) => {
    // console.log(req.session.user);
    if (req.session.user == null) {
        return res.status(403).send("Require Admin Role!");
    }
    if (req.session.user.role != "admin") {
        return res.status(403).send("Require Admin Role!");
    }
    next();
}

exports.isWriter = async (req, res, next) => {
    if (req.session.user == null) {
        return res.status(403).send("Require writer Role!");
    }
    if (req.session.user.role != "writer") {
        return res.status(403).send("Require writer Role!");
    }
    next();
}

exports.isSubcriber = async (req, res, next) => {
    if (req.session.user == null) {
        return res.status(403).send("Require subcriber Role!");
    }
    if (req.session.user.role != "subcriber") {
        return res.status(403).send("Require subcriber Role!");
    }
    next();
}

exports.isEditor = async (req, res, next) => {
    if (req.session.user == null) {
        return res.status(403).send("Require Editor Role!");
    }
    if (req.session.user.role != "editor") {
        return res.status(403).send("Require Editor Role!");
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