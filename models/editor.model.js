const db = require('../utils/db');
const { findNameCateByID } = require('./category.model');

module.exports = {
    async allEditor(){
      const rows = await db('Editors');
      if (rows.length === 0)
          return null;
      for(i=0;i<rows.length;i++){
        let cate = await db('Categories').where('ID', rows[i].CatID)
        rows[i].CateName = cate[0].Name;
      }
      
      return rows;
    },
    async countEditor(){
      const rows = await db('Editors')
        .count('*', { as: 'total' })
      return rows[0].total;
    },
    async findByUsername(username){
        const rows = await db('Editors').where('username', username);
        if (rows.length === 0)
          return null;
        return rows[0];
      },

      async findByEmail(email){
        const rows = await db('Editors').where('Email', email);
        if (rows.length === 0)
          return null;
        return rows[0];
      },

    //sure has row
    async getNameByID(id){
      const rows = await db('Editors').where('ID', id);
        if (rows.length === 0)
          return null;
        return rows[0].Name;
    },
    async getCateID(id){
      const rows = await db('Editors').where('ID', id);
        if (rows.length === 0)
          return null;
        return rows[0].CatID;
    },
    async findByID(id){
      const rows = await db('Editors').where('ID', id);
      if (rows.length === 0)
        return null;
      return rows[0];
    },

    async changePassByID(hash,ID){
      return db('Editors').where('ID', ID).update('Password',hash);
    },

    async updateGeneralInfor(ID, name, email, birthday, address, catid){
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
      
      await db('Editors')
      .where('ID', ID)
      .update({
        Name: name,
        BirthDay: dob,
        Email: email,
        Address: address,
        CatID: catid,
      });
    },

    async getCategoryNameByEditorID(edtid){
      let rows = await db('Editors')
      .where({
        ID:edtid
      })
      .select('CatID');
       let cate_name = await findNameCateByID(rows[0].CatID);
       return cate_name;
    },
    async add(user){
      return db('Editors').insert(user);
    },
    async delUser(userid) {
      const role = 'editor';
      await db('Comments')
      .where({
          ReaderID: userid,
          RoleReaderID: role,
      })
      .del();
      const listpost = await db('Drafts')
      .where({
          EditorID: userid,
      })
      
      for(i=0;i<listpost.length;i++){
        await db('Posts').where('ID', listpost[i].PostID).update('StateID', 0);
      }
      return db('Editors').where('ID', userid).del();
    },
}