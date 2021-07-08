const admin = require('../models/admin.model')
const editor = require('../models/editor.model')
const reader = require('../models/reader.model')
const writer = require('../models/writer.model')
const bcrypt = require('bcryptjs');
const moment = require('moment');
const nodemailer = require('nodemailer');


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

exports.is_available_email = async (req, res)=>{
    const email = req.query.email;
    const rowsReader = await reader.findByEmail(email);
    const rowsWriter = await writer.findByEmail(email);
    const rowsEditor = await editor.findByEmail(email);
    const rowsAdmin = await admin.findByEmail(email);
    if (rowsReader === null  && rowsWriter === null && rowsAdmin === null && rowsEditor === null) 
        return res.json(false);
    return res.json(true);
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
    //console.log(req.body.username);
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

var email;
let otp = Math.random();
otp = otp * 1000000;
otp = parseInt(otp);
console.log("OTP: ",otp);

exports.reset_password = async (req, res) => {
    email = req.body.email;

    let testAccount = await nodemailer.createTestAccount();

    let transporter = nodemailer.createTransport({
        host: "smtp.ethereal.email",
        port: 587,
        secure: false, // true for 465, false for other ports
        auth: {
            user: testAccount.user, // generated ethereal user
            pass: testAccount.pass, // generated ethereal password
        },
    });
    
    var mailOptions={
        to: email,
       subject: "Otp for registration is: ",
       html: "<h3>OTP for account verification is </h3>"  + "<h1 style='font-weight:bold;'>" + otp +"</h1>" // html body
     };
     
     transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return console.log(error);
        }
        console.log('Message sent: %s', info.messageId);   
        console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
  
        res.redirect('/reset-password/getOTP');
    });
}

exports.handleReceiveOTP = (req, res) =>{
    console.log(req.body.otp, otp);
    if(req.body.otp==otp){
        res.redirect('/reset-password/changePassword');
    }
    else{
        res.render('account/enter_otp',{
            msg : 'otp is incorrect',
        });
    }
}

exports.resendOTP = async (req, res) =>{
    otp = Math.random();
    otp = otp * 1000000;
    otp = parseInt(otp);
    console.log(otp);

    let testAccount = await nodemailer.createTestAccount();

    let transporter = nodemailer.createTransport({
        host: "smtp.ethereal.email",
        port: 587,
        secure: false, // true for 465, false for other ports
        auth: {
            user: testAccount.user, // generated ethereal user
            pass: testAccount.pass, // generated ethereal password
        },
    });
    var mailOptions={
        to: email,
       subject: "Otp for registration is: ",
       html: "<h3>OTP for account verification is </h3>"  + "<h1 style='font-weight:bold;'>" + otp +"</h1>" // html body
     };
     
     transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return console.log(error);
        }
        console.log('Message sent: %s', info.messageId);   
        console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
        res.redirect('/reset-password/getOTP');
    });
}

exports.changePasswordForgot = async (req, res)=>{
    const hash = bcrypt.hashSync(req.body.password, 10);
    const rowsReader = await reader.findByEmail(email);
    const rowsWriter = await writer.findByEmail(email);
    const rowsEditor = await editor.findByEmail(email);
    const rowsAdmin = await admin.findByEmail(email);
    if (rowsReader !== null){
        await reader.changePassByID(hash,rowsReader.ID);
    }
    else if (rowsWriter !== null){
        await writer.changePassByID(hash,rowsWriter.ID);
    }
    else if (rowsEditor !== null){
        await editor.changePassByID(hash,rowsEditor.ID);
    }
    else if (rowsAdmin !== null){
        await admin.changePassByID(hash,rowsReader.ID);
    }
    
  res.redirect('/login?register=2');
}


exports.signout = (req, res) => {
    //req.session.user = null;
    //res.redirect('/');
    req.session.destroy(function(err) {
        res.redirect('/');
    });
}

exports.getEditProfileView = (req, res) => {
    //req.session.user = null;
    //res.redirect('/');

    res.render('user/subcriber/editprofile');
}

exports.changePassword = async (req, res) => {
    //req.session.user = null;
    //res.redirect('/');
    const rows_reader = await reader.findByID(req.session.user.id);
    const ret = bcrypt.compareSync(req.body.oldPassword, rows_reader.Password);
    const hash = bcrypt.hashSync(req.body.newPassword, 10);
    if(ret===true){
        await reader.changePass(req.session.user.id, hash);
        res.render('user/subcriber/profile');
    }
    else{
        return res.render('user/subcriber/editprofile', {
            err_message: 'Invalid password',
        })
    }
}
exports.updateProfile = async (req, res) => {
    console.log(req.body.raw_dob);
    await reader.updateGeneralInfor(req.session.user.id, req.body.fullName, req.body.email, req.body.raw_dob );
    
    req.session.user.name = req.body.fullName;
    req.session.user.email = req.body.email;
    req.session.user.birthday = req.body.raw_dob;
    
    res.redirect('/subcriber');
    
  };
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
        birthday: moment(rows.BirthDay).format('DD/MM/YYYY'),
        email: rows.Email,
        role: role,
        expTime: moment(rows.ExpTime).format('MMMM D YYYY, HH:mm:ss'),
        logged: true

    };
    //res.locals.session = req.session.user;
    //console.log(req.locals.session);
    console.log(req.session.user);
    // TODO: render cac file sao cho phu hop voi tung role
    const url = req.session.retURL || "/" +role;
    return res.redirect(url )
}
