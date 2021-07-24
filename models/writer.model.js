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
    async updateGeneralInfor(ID, name, email, birthday, address, nickname){
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
      await db('Writers')
      .where('ID', ID)
      .update({
        Name: name,
        BirthDay: dob,
        Email: email,
        Address: address,
        NickName: nickname
      });
    },

    async findNameByID(id){
      const rows = await db('Writers')
      .where('ID', id)
      .select('NickName');
      if (rows.length === 0)
        return null;
      return rows[0].NickName;
    },
    async add(user){
      return db('Writers').insert(user);
    },
    async delUser(userid) {
      const role = 'writer';
      await db('Comments')
      .where({
          ReaderID: userid,
          RoleReaderID: role,
      })
      .del();
      await db('Post')
      .where({
          WriterID: userid,
      })
      .del();
      return db('Readers').where('ID', userid).del();
    },
}