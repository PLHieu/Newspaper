const db = require('../utils/db')

module.exports = {
    findAll(){
      return db('Writers');
    },

    async findByUsername(username){
        const rows = await db('Writers').where('username', username);
        if (rows.length === 0)
          return null;
        return rows[0];
    },

    async findByID(id){
      const rows = await db('Writers').where('ID', id);
      if (rows.length === 0)
        return null;
      return rows[0];
    },

    async findByEmail(email){
      const rows = await db('Writers').where('Email', email);
      if (rows.length === 0)
        return null;
      return rows[0];
    },

    changePassByID(hash,ID){
      return db('Writers').where('ID', ID).update('Password',hash);
    },
    async updateGeneralInfor(wrtID, wrtName, wrtEmail, wrtBirthday, wrtNickname){
      //dob = moment(readerBirthday).format("YYYY-MM-DD");
      let dob = wrtBirthday.slice(3,6)+ wrtBirthday.slice(0,3) + wrtBirthday.slice(6,10);
      
      //console.log(dob);
      var date = new Date(dob);
      date.setDate(date.getDate()+1);
      
      dob = date.toISOString();
      dob = dob.slice(0,10);
      await db('Writers')
      .where('ID', wrtID)
      .update({
        Name: wrtName,
        BirthDay: dob,
        Email: wrtEmail,
        NickName: wrtNickname,
      });
    },
}