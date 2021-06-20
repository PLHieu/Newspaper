const express = require('express');
const morgan = require('morgan');
const path = require('path');

const app = express();
app.use(morgan('dev'));

// body parser
app.use(express.json());
app.use(express.urlencoded({
  extended: true
}));

//static file
app.use(express.static('public'));
//session 
require('./middlewares/sessionInit.mdw')(app);
// routes
app.get('/', function (req, res) {
  res.send("Hello World");
});
require('./routes/authen.routes')(app);
require('./routes/user.routes')(app);

// views
require('./middlewares/view.mdw')(app);



const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});


