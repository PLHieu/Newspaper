const { SubcriberPage } = require("../controllers/testuser.controllers");
const express = require('express');
const router = express.Router();

router.get('/', SubcriberPage)

module.exports = router;