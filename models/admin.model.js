const db = require('../utils/db')

module.exports = {
    async findByUsername(username){
        const rows = await db('Admins').where('username', username);
        if (rows.length === 0)
          return null;
        return rows[0];
      },

      async findByEmail(email){
        const rows = await db('Admins').where('Email', email);
        if (rows.length === 0)
          return null;
        return rows[0];
      },

      async findByID(id){
        const rows = await db('Admins').where('ID', id);
        if (rows.length === 0)
          return null;
        return rows[0];
      },

      changePassByID(hash,ID){
        return db('Admins').where('ID', ID).update('Password',hash);
      },

      async updateGeneralInfor(ID, name, email, birthday, address){
        let dob = birthday.slice(3,6)+ birthday.slice(0,3) + birthday.slice(6,10);
        var date = new Date(dob);
        date.setDate(date.getDate()+1);
        dob = date.toISOString();
        dob = dob.slice(0,10);

        await db('Admins')
        .where('ID', ID)
        .update({
          Name: name,
          BirthDay: dob,
          Email: email,
          Address: address,
        });
      },
}