//const { updateProfile } = require('../controllers/authen.controllers');
const db = require('../utils/db')
const moment = require('moment')
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
    async findByID(readerID){
      const rows = await db('Readers').where('ID', readerID);
        if (rows.length === 0)
          return null;
        return rows[0];
    },
    async updateGeneralInfor(ID, name, email, birthday, address){
      let dob = birthday.slice(3,6)+ birthday.slice(0,3) + birthday.slice(6,10);
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

    changePassByID(hash,ID){
      return db('Readers').where('ID', ID).update('Password',hash);
    },

    updateOTP(readerID){
      return  db('Readers').where('ID', readerID).update('OTP',-1);
    }
}