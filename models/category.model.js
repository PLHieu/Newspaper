const db = require('../utils/db')
const tags_db = require('./tag.model')

module.exports = {
    findChildCategories: findChildCategories,
    findDadCategories: findDadCategories,
    findListChild: findListChild,
    findLevel: findLevel,
    findRelative: findRelative,
    findNameCateByID: findNameCateByID,
    findByCateName: findByCateName,
    findCateByID: findCateByID,
    getTag: tags_db.findByID,
    del: del,
    add: add,
    updateCategory: updateCategory,
    getCategory: getCategory,
    all() {
        return db('Categories');
    },

    getAllChildren() {
        return db('Categories').whereNot('ParentID', null);
    },
    
    
}

async function updateCategory(catID, name, dad){
    const level = await findLevel(catID);
    if (level == '1' && dad != '0'){
        const child = await findChildCategories(catID);
        console.log(child);
        for (i=0; i<child.length; i++){
            await db('Categories').where('ID', child[i].ID).update({
                ParentID: dad,
            })
        }
        return db('Categories').where('ID', catID).update({
            ParentID: dad,
            Name: name,
        })
    }
    if(dad == '0'){
        return db('Categories').where('ID', catID).update({
            ParentID: null,
            Name: name,
        })
    }
    return db('Categories').where('ID', catID).update({
        ParentID: dad,
        Name: name,
    })
}
async function del(catID){
    /*const level = await findLevel(catID);
    if(level == '1'){
       await db('Categories').where('ParentID', catID).del();
    }*/
    return db('Categories').where('ID', catID).del();
}
async function add(catName, catParent){
    let cate = null;
    if (catParent == '0'){
        cate = {Name: catName, ParentID: null};
    }
    else{
        cate = {Name: catName, ParentID: catParent};
    }
    return db('Categories').insert(cate);
    
}
async function findByCateName(catName){
    const rows = await db('Categories').where('Name', catName);
    if (rows.length === 0)
      return null;
    return rows[0];
}
async function findNameCateByID(catID) {
    cat = await db('Categories').where('ID', catID);
    //console.log(cat);
    if (cat.length === 0)
        return null;
    //console.log(cat[0].Name);
    return cat[0].Name;
}
async function findCateByID(catID) {
    cat = await db('Categories').where('ID', catID);
    //console.log(cat);
    if (cat.length === 0)
        return null;
    //console.log(cat[0].Name);
    return cat[0];
}

/*
    Tim danh sach Category la Dad
*/
async function findDadCategories() {
    const result = await db('Categories')
        .where({
            ParentID: null
        })
    return result;
}
/*
    Tim danh sach Category la Child
*/
async function findListChild() {
    const result = await db('Categories')
        .whereNotNull('ParentID')
    return result;
}
/*
Tim danh sach Category la con cua Parent Category 
*/
async function findChildCategories(parentCate) {
    const result = await db('Categories')
        .where({
            ParentID: parentCate
        })
    return result;
}

/*
    Tim xem Level cua Category
    Hien tai co 2 Level (1 va 2)
*/
async function findLevel(idcate) {
    const result = await db('Categories')
        .where({
            ID: idcate
        })
        // console.log(result)
    if (result.length === 0) {
        return false;
    }
    if (result[0].ParentID == null) {
        return 1;
    }
    return 2;
}

/*
    Truyen vao mot category
    Tra ve mot object 
*/
async function findRelative(idcate) {
    const level = await findLevel(idcate);
    let isDad;
    let Dad;
    let Children;
    if (level == 1) {
        isDad = true;
        Dad = await getCategory(idcate);
        Children = await findChildCategories(idcate);
    } else if (level == 2) {
        isDad = false;
        let current = await getCategory(idcate);
        let parentID = current.ParentID;
        Dad = await getCategory(parentID);
        Children = await findChildCategories(Dad.ID);
    }

    // console.log(isDad, Dad, Children );

    for (let i = 0; i < Children.length; i++) {
        if (Children[i].ID == idcate) {
            Children[i].selected = true;
        } else {
            Children[i].selected = false;
        }
    }

    // console.log(Children);
    return {
        isDad: isDad,
        Dad: Dad,
        Children: Children
    }
}


async function getCategory(id) {
    const result = await db('Categories')
        .where({
            ID: id
        })
    return result[0];
}
