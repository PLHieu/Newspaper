exports.guestPage = (req, res) => {
    res.status(200).send("Public Content.");
};

exports.editorPage = (req, res) => {
    res.status(200).render("user/editor");
};

exports.adminPage = (req, res) => {
    res.status(200).render("user/admin");
};

exports.writerPage = (req, res) => {
    res.status(200).render("user/writer");
};

exports.SubcriberPage = (req, res) => {
    res.status(200).render("user/subcriber");
};
