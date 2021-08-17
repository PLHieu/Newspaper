/*RULE1
{
    ID,
    Title,
    WriterID,
    CatID,
    StateID,
    Content,
    Abstract,
    WriteTime,
    PubTime,
    Views,
    HighLight
}
--> 
{
    ID,
    TieuDe,
    TomTat,
    NgayDang,
    AnhDaiDien
}




*/





module.exports = {
    rule1: {
        "ID": "ID",
        "Title": "TieuDe",
        "Abstract": "TomTat",
        "PubTime": "NgayDang",
        "Premium": "Premium",
        "WriterID": "WriterID",
    },
    ruleCate: {
        "ID": "CateID",
        "Name": "CateName",
        "ParentID": "ParentID",
    },
    ruleTag: {
        "ID": "TagID",
        "Name": "TagName",
    }
}