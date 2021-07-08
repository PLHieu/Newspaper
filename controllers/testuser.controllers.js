exports.guestPage = (req, res) => {
    res.status(200).render("home2");
};

exports.editorPage = (req, res) => {
    res.status(200).render("user/editor");
};

exports.adminPage = (req, res) => {
    res.status(200).render("user/admin");
};

exports.writerPage = (req, res) => {
    res.status(200).render("user/writer/main");
};

exports.SubcriberPage = (req, res) => {
    res.status(200).render("user/subcriber/profile");
};
