//const { updateProfile } = require('../controllers/authen.controllers');
const db = require('../utils/db');
const comment_db = require('./comment.model');
const moment = require('moment');
const { now } = require('moment');
module.exports = {
    async findByUsername(username){
        const rows = await db('Readers').where('username', username);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    async findByEmail(email){
      const rows = await db('Readers').where('Email', email);
      if (rows.length === 0)
        return null;
      return rows[0];
    },

    async add(user){
      return db('Readers').insert(user);
    },

    async changePass(readerID, pass){
      await db('Readers')
      .where('ID', readerID)
      .update({
        Password: pass,
      });
    },
    async AcceptPremium(readerID){
      let date = new Date();
      date.setDate(date.getDate() + 7);
      date = moment(date).format('YYYY-MM-DD HH:mm:ss');
      
      await db('Readers')
      .where('ID', readerID)
      .update({
        ExpTime: date,
        SubPremium: 0
      });
    },
    async CancelPremium(readerID){
      
      await db('Readers')
      .where('ID', readerID)
      .update({
        ExpTime: null,
        SubPremium: 0
      });
    },
    async findByID(readerID){
      const rows = await db('Readers').where('ID', readerID);
        if (rows.length === 0)
          return null;
        return rows[0];
    },
    findListSubPremium(){
      return db('Readers').where('SubPremium', 1);
    },
    async findAll(){
      const rows = await db('Readers');
        if (rows.length === 0)
          return null;
        return rows;
    },
    async countReader(){
      const rows = await db('Readers')
        .count('*', { as: 'total' })
      return rows[0].total;
    },

    async updateGeneralInfor(ID, name, email, birthday, address){
      
      let dob = '';
      if(birthday.length >10){
        dob = birthday.slice(3,6)+ birthday.slice(0,3) + birthday.slice(6,10);
        var date = new Date(dob);
        date.setDate(date.getDate()+1);
        dob = date.toISOString();
        dob = dob.slice(0,10);
      }
      else{
        dob = birthday.slice(6) + '-' + birthday.slice(3,5) + '-' + birthday.slice(0,2);
        
      }
      console.log(dob);
      await db('Readers')
      .where('ID', ID)
      .update({
        Name: name,
        BirthDay: dob,
        Email: email,
        Address: address
      });
    },
    async updateNullExp(readerID){
      await db('Readers')
      .where('ID', readerID)
      .update({
        ExpTime: null,
      });
    },
    async subPremium(val, readerID){
      await db('Readers')
      .where('ID', readerID)
      .update({
        SubPremium: val,
      });
    },
    async delUser(userid) {
      const role = 'subcriber';
      await db('Comments')
      .where({
          ReaderID: userid,
          RoleReaderID: role,
      })
      .del();
      return db('Readers').where('ID', userid).del();
    },
    
    changePassByID(hash,ID){
      return db('Readers').where('ID', ID).update('Password',hash);
    },

    updateOTP(readerID){
      return  db('Readers').where('ID', readerID).update('OTP',-1);
    }

}