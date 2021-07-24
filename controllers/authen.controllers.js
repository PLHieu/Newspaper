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
    let otp = Math.random();
    otp = otp * 1000000;
    otp = parseInt(otp);
    console.log("OTP: ",otp);
    const email = req.body.email;
    const user = {
        UserName: req.body.username,
        Password: hash,
        BirthDay: dob,
        Name: req.body.name,
        Email: req.body.email,
        Address: req.body.address,
        ExpTime: null,
        OTP: otp
    }
    await reader.add(user);

    let transporter = nodemailer.createTransport(
        {
            service: 'gmail',
            auth: {
              user: 'newspaper.vuonghieutrinh@gmail.com',
              pass: 'vuonghieutrinh'
            },
    });
    
    var mailOptions={
        from: "newspaper.vuonghieutrinh@gmail.com",
        to: email,
       subject: "OTP for Register New Newspaper Account: ",
       html: `<p>Dear you,${email}</p>`+
       "<h3>OTP for account verification helping you register our application is </h3>"  + 
       "<h1 style='font-weight:bold;'>" + otp +"</h1>" +
       "<p>Thank you</p>",
    };
     
     transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return console.log(error);
        }
        console.log('Message sent: %s', info.messageId);   
        console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
  
        res.redirect(`/getOTP?register=1&email=${email}`);
    });
}

exports.is_available = async (req, res)=>{
    const username = req.query.username;
    const rowsReader = await reader.findByUsername(username);
    const rowsWriter = await writer.findByUsername(username);
    const rowsEditor = await editor.findByUsername(username);
    const rowsAdmin = await admin.findByUsername(username);
    if (rowsReader === null  && rowsWriter === null && rowsAdmin === null && rowsEditor === null)  
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
        console.log("OTP ",rows_reader.OTP);
        if (rows_reader.OTP != -1){
            console.log("OTP ",rows_reader.OTP);
            return new Promise((resolve,reject)=>{
                let transporter = nodemailer.createTransport(
                    {
                        service: 'gmail',
                        auth: {
                        user: 'newspaper.vuonghieutrinh@gmail.com',
                        pass: 'vuonghieutrinh'
                        },
                });
                
                var mailOptions={
                    from: "newspaper.vuonghieutrinh@gmail.com",
                    to: rows_reader.Email,
                subject: "OTP for Register New Newspaper Account: ",
                html: `<p>Dear you,${rows_reader.Email}</p>`+
                "<h3>OTP for account verification helping you register our application is </h3>"  + 
                "<h1 style='font-weight:bold;'>" + rows_reader.OTP +"</h1>" +
                "<p>Thank you</p>",
                };
                
                transporter.sendMail(mailOptions, (error, info) => {
                    if (error) {
                        console.log(error);
                        resolve(false);
                    }
                    else{
                        console.log('Message sent: %s', info.messageId);   
                        console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
                        resolve(true);
                    }
                    res.redirect(`/getOTP?register=1&email=${rows_reader.Email}&noactive=1`);
                });
            });
        }
        return checkPassword("subcriber", rows_reader, req, res);
        /*if (rows_reader.ExpTime!=null)
            return checkPassword("subcriber", rows_reader, req, res);
        else return checkPassword("guest", rows_reader, req, res);*/
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

/*
If you use a plain password, then you should allow access for less secure apps. 

Go to the Less secure app access section of your Google Account. 
Turn Allow less secure apps on.
Additionally, you should enable Display Unlock Captcha. 
If you are using 2-Step Verification, you should sign in with App Passwords. To create your password:

Go to the Security section of your Gmail account. 
Choose App Passwords in the Signing into Google block.
Select the app and device from the list and press Generate. 
Please note that you can use it for your personal account only.
*/

var email;
let otp;

exports.reset_password = async (req, res) => {
    email = req.body.email;
    otp = Math.random();
    otp = otp * 1000000;
    otp = parseInt(otp);
    console.log("OTP: ",otp);

    let transporter = nodemailer.createTransport(
        {
            service: 'gmail',
            auth: {
              user: 'newspaper.vuonghieutrinh@gmail.com',
              pass: 'vuonghieutrinh'
            },
    });
    
    var mailOptions={
        from: "newspaper.vuonghieutrinh@gmail.com",
        to: email,
       subject: "OTP for Reset Password on Account Newspaper: ",
       html: "<p>Dear you,</p>"+
       "<h3>OTP for account verification, help you reset password is </h3>"  + 
       "<h1 style='font-weight:bold;'>" + otp +"</h1>" +
       "<p>This code will expire ... hours after this email was sent</p>"+
       "<p>Thank you</p>",
    };
     
     transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return console.log(error);
        }
        console.log('Message sent: %s', info.messageId);   
        console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
  
        res.redirect('/getOTP');
    });
}

exports.handleReceiveOTP = async (req, res) =>{
    console.log(req.body);
    if (req.body.register){
        const account = await reader.findByEmail(req.body.email);
        console.log(account);
        console.log("REGISTER: ",req.body.otp, account.OTP);
        if (req.body.otp == account.OTP){
                await reader.updateOTP(account.ID);
            return res.redirect('/login?register=1');
        }
        else{
            return res.render('account/enter_otp',{
                msg : 'otp is incorrect',
                activeAccount: true
            });
        }
    }
    console.log("NOT REGISTER: ",req.body.otp);
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

    let transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: 'newspaper.vuonghieutrinh@gmail.com',
              pass: 'vuonghieutrinh'
            },
    });
    
    var mailOptions={
        from: "newspaper.vuonghieutrinh@gmail.com",
        to: email,
       subject: "Otp for registration is: ",
       html: "<h3>OTP for account verification is </h3>"  + 
       "<h1 style='font-weight:bold;'>" + otp +"</h1>" ,
    };
     
     transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return console.log(error);
        }
        console.log('Message sent: %s', info.messageId);   
        console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
        res.redirect('/getOTP');
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

function checkPassword(role, rows, req, res) {
  const ret = bcrypt.compareSync(req.body.password, rows.Password);
  
  if (ret===false){
    return res.render('account/login', {
        err_message: 'Invalid password',
    })
  }
  else{
    if(role === 'writer'){
      if (rows.Active=='0'){
        return res.render('account/login', {
            err_message: 'Invalid account',
        })
      }else{
        handle_login_successfully(role, rows, req, res);
      }
    }
    else{
        handle_login_successfully(role, rows, req, res);
    }
  }
  //return authInfor;
}
exports.subcribePremium = async (req, res) => {
    await reader.subPremium(1, req.session.user.id);
    req.session.user.subPremium = 1;
    //window.alert('đăng ký thành công, đợi admin duyệt');
    res.redirect('/subcriber');
    
};

function handle_login_successfully(role, rows, req, res) {
    // dang nhap thanh cong thi luu thong tin vao trong session 
    let adm = null, sub = null, wrt = null, edt = null, Premium = 1, nickname = null;
    let exp = moment(rows.ExpTime).format('MMMM D YYYY, HH:mm:ss');
    let subPre = null;
    console.log(rows);
    if (role == 'admin'){
        adm = 1;
    } 
    if (role == 'subcriber'){
        sub = 1;
        if (rows.ExpTime == null){
            Premium = null;
            exp = null;
            if (rows.SubPremium === 1){
                subPre = 1;
            } 
        }
        else{
            var countDownDate = new Date(exp).getTime();
            var now = new Date().getTime();
        
            // Find the distance between now and the count down date
            var distance = now - countDownDate;
                
            // Time calculations for days, hours, minutes and seconds
            //var days = Math.floor(distance / (1000 * 60 * 60 * 24)); % (1000 * 60 * 60))
            //var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor(distance  / (1000 * 60));
            var minutesleft = 7*24*60  - minutes;
            
            if(minutesleft<=0){
                exp = null;
                reader.updateNullExp(rows.ID);
                Premium = null;
            }
        }
    }
    if (role == 'writer'){
        wrt = 1;
        nickname = rows.NickName;
    }
    if (role == 'editor'){
        edt = 1;
    }
    
    req.session.user = {
        id: rows.ID,
        name: rows.Name,
        username: rows.UserName,
        address: rows.Address,
        birthday: moment(rows.BirthDay).format('DD/MM/YYYY'),
        email: rows.Email,
        role: role,
        nickname: nickname,
        expTime: exp,
        subPremium: subPre,
        logged: true,
        admin: adm,
        subcriber: sub,
        writer: wrt,
        editor: edt,
        premium: Premium,
    };
    //res.locals.session = req.session.user;
    //console.log(req.locals.session);
    console.log(req.session.user);
    // TODO: render cac file sao cho phu hop voi tung role
    const url = req.session.retURL || "/" +role;
    return res.redirect(url )
}
