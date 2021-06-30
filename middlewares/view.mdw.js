const exphbs = require('express-handlebars');
hbs_sections = require('express-handlebars-sections');

module.exports = function (app) {
    app.engine('hbs', exphbs({
        defaultLayout: 'main.hbs',
        helpers: {
            section: hbs_sections(),
            info: parseAuthorDate,
        }
    }));
    app.set('view engine', 'hbs');
}


function parseAuthorDate(post) {
    let published_date = new Date(post.NgayDang)
    const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    return post.TacGia + " - " 
    + months[published_date.getMonth()]
    + ' ' + published_date.getDate() 
    + ' ' + published_date.getFullYear();
}