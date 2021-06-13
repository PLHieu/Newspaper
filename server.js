const express = require('express');
const path = require('path');

const app = express();

// middleware
app.use(express.urlencoded({
    extended: true
}));
app.use(express.static('public'));
require('./middlewares/views.mdw')(app);
require('./middlewares/routes.mdw')(app);

var server = app.listen(3000, function () {
    console.log('Newspaper Server is running')
});



