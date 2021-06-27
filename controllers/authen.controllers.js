const admin = require('../models/admin.model')
const editor = require('../models/editor.model')
const reader = require('../models/reader.model')
const writer = require('../models/writer.model')
const bcrypt = require('bcryptjs');
const moment = require('moment');


exports.register = async function(req, res) {
    const hash = bcrypt.hashSync(req.body.raw_password, 10);
    const dob = moment(req.body.raw_dob,'DD/MM/YYYY').format('YYYY-MM-DD');
    const user = {
        UserName: req.body.username,
        Password: hash,
        BirthDay: dob,
        Name: req.body.name,
        Email: req.body.email,
        Address: req.body.address,
        ExpTime: null
    }
    await reader.add(user);
  res.render('account/login', {
      after_register: "Bạn đã đăng kí thành công"
  });
}

exports.is_available = async (req, res)=>{
    const rows = await reader.findByUsername(req.query.username);
    if (rows.length===0) 
        return res.json(true);
    return res.json(false);
}


exports.signin = async (req, res) => {
    const rows_admin = await admin.findByUsername(req.body.username);
    if (rows_admin != null) {
        return checkPassword("admin", rows_admin, req, res);
    }

    const rows_editor = await editor.findByUsername(req.body.username);
    if (rows_editor != null) {
        return checkPassword("editor", rows_editor, req, res);
    }

    const rows_reader = await reader.findByUsername(req.body.username);
    if (rows_reader != null) {
        if (rows_reader.ExpTime!=null)
            return checkPassword("subcriber", rows_reader, req, res);
        else return checkPassword("guest", rows_reader, req, res);
    }

    const row_writer = await writer.findByUsername(req.body.username);
    if (row_writer != null) {
        return checkPassword("writer", row_writer, req, res);
    }

    // Khong ton tai tai khoang trong he thong 
    return res.render('account/login', {
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
    return res.render('account/login', {
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
