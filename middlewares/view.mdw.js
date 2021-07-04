const exphbs = require('express-handlebars');
hbs_sections = require('express-handlebars-sections');
module.exports = function (app) {
    app.engine('hbs', exphbs({
        defaultLayout: 'main.hbs',
        helpers: {
            section: hbs_sections(),
            info: parseAuthorDate,
            switch: function(val, options) {
                this.switch_value = val;
                return options.fn(this);
            },
            case: function(val, options) {
                if (val === this.switch_value) {
                    return options.fn(this);
                }
            },
            eq: function(val1, val2, options) {
                if (val1 === val2) {
                    return options.fn(this);
                }
                return options.inverse(this);
            },
            math: function(lvalue, operator, rvalue) {
                lvalue = parseFloat(lvalue);
                rvalue = parseFloat(rvalue);
                return {
                    "+": lvalue + rvalue,
                    "-": lvalue - rvalue,
                    "*": lvalue * rvalue,
                    "/": lvalue / rvalue,
                    "%": lvalue % rvalue
                }[operator];
            },
        }}));
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