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
  res.redirect('/login?register=1');
}

exports.is_available = async (req, res)=>{
    const username = req.query.username;
    const rows = await reader.findByUsername(username);
    if (rows === null) 
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

exports.reset_password = (req, res) => {
    res.send("to do to Reset Password")
}


exports.signout = (req, res) => {
    //req.session.user = null;
    //res.redirect('/');
    req.session.destroy(function(err) {
        res.redirect('/');
    });
}


function checkPassword(role, rows, req, res) {
  const ret = bcrypt.compareSync(req.body.password, rows.Password);
  if (ret===false){
    return res.render('account/login', {
        err_message: 'Invalid password',
    })
  }
   handle_login_successfully(role, rows, req, res);
  //return authInfor;
}


function handle_login_successfully(role, rows, req, res) {
    // dang nhap thanh cong thi luu thong tin vao trong session 
    req.session.user = {
        id: rows.ID,
        name: rows.Name,
        username: rows.UserName,
        address: rows.Address,
        birthday: rows.BirthDay,
        email: rows.Email,
        role: role,
        expTime: moment(rows.ExpTime).format('MMMM Do YYYY, HH:mm:ss'),
        logged: true
    };
    //res.locals.session = req.session.user;
    //console.log(req.locals.session);
    //console.log(req.session.user);
    // TODO: render cac file sao cho phu hop voi tung role
    const url = req.session.retURL || "/" +role;
    return res.redirect(url )
}
