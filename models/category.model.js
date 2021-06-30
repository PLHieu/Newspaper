const db = require('../utils/db')
module.exports = {
    findChildCategories: findChildCategories,
    findLevel: findLevel,
    findRelative: findRelative,
    getTag: getTag,
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


async function getTag(idTag) {
    const result = await db('Tags')
        .where({
            ID: idTag
        })
    // console.log(result[0]);
    return result[0];
}