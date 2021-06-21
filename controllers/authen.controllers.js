const admin = require('../models/admin.model')
const editor = require('../models/editor.model')
const subcriber = require('../models/subcriber.model')
const writer = require('../models/writer.model')
const bcrypt = require('bcryptjs');

exports.signin = async (req, res) => {
    const rows_admin = await admin.findByUsername(req.body.username);
    if (rows_admin != null) {
        return checkPassword("admin", rows_admin, req, res);
    }

    const rows_editor = await editor.findByUsername(req.body.username);
    if (rows_editor != null) {
        return checkPassword("editor", rows_editor, req, res);
    }

    const rows_subcriber = await subcriber.findByUsername(req.body.username);
    if (rows_subcriber != null) {
        return checkPassword("subcriber", rows_subcriber, req, res);
    }

    const row_writer = await writer.findByUsername(req.body.username);
    if (row_writer != null) {
        return checkPassword("writer", row_writer, req, res);
    }

    // Khong ton tai tai khoang trong he thong 
    return res.render('login', {
        err_message: 'Invalid Username',
    })
}


exports.signout = (req, res) => {
    req.session.user = null;
    res.redirect('/login');
}

function checkPassword(role, rows, req, res) {
  const ret = bcrypt.compareSync(req.body.password, rows.Password);
  if (ret===false){
    return res.render('login', {
        err_message: 'Invalid password',
    })
  }
  handle_login_successfully(role, rows, req, res);
}

function handle_login_successfully(role, rows, req, res) {
    // dang nhap thanh cong thi luu thong tin vao trong session 
    req.session.user = {
        name: rows.Name,
        username: rows.UserName,
        address: rows.Address,
        birthday: rows.BirthDay,
        email: rows.Email,
        role: role,
        logged: true
    };
    // TODO: render cac file sao cho phu hop voi tung role
    return res.redirect("/" +role )
}
