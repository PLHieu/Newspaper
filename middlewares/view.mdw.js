const exphbs = require('express-handlebars');
hbs_sections = require('express-handlebars-sections');
module.exports = function(app) {
    app.engine('hbs', exphbs({
        defaultLayout: 'main.hbs',
        extname: 'hbs',
        helpers: {
            section: hbs_sections(),
            info: parseAuthorDate,
            switch: function(val, options) {
                this.switch_value = val;
                return options.fn(this);
            },
            case: function(val, options) {
                if (val == this.switch_value) {
                    return options.fn(this);
                }
            },
            eq: function(val1, val2, options) {
                if (val1 == val2) {
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
            getDate: getDateFromDatetime,
            countPosts: function(list_posts) {
                return list_posts.length;
            },
            firstChar: (word) => {
                return word.charAt(0);
            },
            ranBgColor: () => {
                colors = ["#34495e", "#2980b9", "#34495e", "#d35400", "#3c6382", "#b71540", "#e58e26"]
                let index = Math.floor(Math.random() * 7);
                return colors[index];

            },
            ranBgColor2: () => {
                colors = ["#22a6b3", "#4834d4", "#eb4d4b", "#0984e3", "#636e72", "#B53471", "#3c6382"]
                let index = Math.floor(Math.random() * 7);
                return colors[index];

            }
        }
    }));
    app.set('view engine', 'hbs');
}

function parseAuthorDate(post) {
    let published_date = new Date(post.NgayDang)
    const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    return post.TacGia + " - " +
        months[published_date.getMonth()] +
        ' ' + published_date.getDate() +
        ' ' + published_date.getFullYear();
}

function getDateFromDatetime(dt_str) {
    let dt = new Date(dt_str);
    const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    return months[dt.getMonth()] +
        ' ' + dt.getDate() +
        ' ' + dt.getFullYear();
}