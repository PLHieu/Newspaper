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
        "PubTime" : "NgayDang",
    }
}