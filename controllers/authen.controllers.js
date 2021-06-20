const admin = require('../models/admin.model')
const editor = require('../models/editor.model')
const subcriber = require('../models/subcriber.model')
const writer = require('../models/writer.model')

exports.signin = async (req, res) => {
    var rows_admin = await admin.findByUsernamePassword(req.body.username, req.body.password);
    if (rows_admin != null) {
        return handle_login_successfully("admin", rows_admin, req, res);
    }

    var rows_editor = await editor.findByUsernamePassword(req.body.username, req.body.password);
    if (rows_editor != null) {
        return handle_login_successfully("editor", rows_editor, req, res);
    }

    var rows_subcriber = await subcriber.findByUsernamePassword(req.body.username, req.body.password);
    if (rows_subcriber != null) {
        return handle_login_successfully("subcriber", rows_subcriber, req, res);
    }

    var row_writer = await writer.findByUsernamePassword(req.body.username, req.body.password);
    if (row_writer != null) {
        return handle_login_successfully("writer", row_writer, req, res);
    }

    // Khong ton tai tai khoang trong he thong 
    return res.status(401).send("Can not login");
}


exports.signout = (req, res) => {
    req.session.destroy();
    res.redirect('/login');
}

function handle_login_successfully(role, rows, req, res) {
    // dang nhap thanh cong thi luu thong tin vao trong session 
    req.session.user = {
        name: rows[0].Name,
        username: rows[0].UserName,
        address: rows[0].Address,
        birthday: rows[0].BirthDay,
        email: rows[0].Email,
        role: role,
        logged: true
    };
    // TODO: render cac file sao cho phu hop voi tung role
    return res.redirect("/" +role )
}
