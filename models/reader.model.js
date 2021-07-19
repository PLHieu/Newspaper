//const { updateProfile } = require('../controllers/authen.controllers');
const db = require('../utils/db')
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
      date = moment(date).format('YYYY-MM-DD HH:mm:ss');
      
      await db('Readers')
      .where('ID', readerID)
      .update({
        ExpTime: date,
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
    async updateGeneralInfor(readerID, readerName, readerEmail, readerBirthday){
      //dob = moment(readerBirthday).format("YYYY-MM-DD");
      let dob = readerBirthday.slice(3,6)+ readerBirthday.slice(0,3) + readerBirthday.slice(6,10);
      
      //console.log(dob);
      var date = new Date(dob);
      date.setDate(date.getDate()+1);
      dob = date.toISOString();
      dob = dob.slice(0,10);

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
    
    changePassByID(hash,ID){
      return db('Readers').where('ID', ID).update('Password',hash);
    },

    updateOTP(readerID){
      return  db('Readers').where('ID', readerID).update('OTP',-1);
    }
}