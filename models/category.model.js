const db = require('../utils/db')
const tags_db = require('./tag.model')

module.exports = {
    findChildCategories: findChildCategories,
    findDadCategories: findDadCategories,
    findListChild: findListChild,
    findLevel: findLevel,
    findRelative: findRelative,
    findNameCateByID: findNameCateByID,
    getTag: tags_db.findByID,
    all() {
        return db('Categories');
    },

    getAllChildren() {
        return db('Categories').whereNot('ParentID', null);
    },




}

async function findNameCateByID(catID) {
    cat = await db('Categories').where('ID', catID);
    //console.log(cat);
    if (cat.length === 0)
        return null;
    //console.log(cat[0].Name);
    return cat[0].Name;
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