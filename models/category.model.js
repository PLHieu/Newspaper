const db = require('../utils/db')
module.exports = {
    /*
        Tim danh sach Category la con cua Parent Category 
    */
    async findChildCategories(parentCate) {
        const result = await db('Categories')
            .where({
                ParentID: parentCate
            })
        return result;
    },

    /*
        Tim xem Level cua Category
        Hien tai co 2 Level (1 va 2)
    */
    async findLevel(idcate) {
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

}