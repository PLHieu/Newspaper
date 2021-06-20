const { writerPage } = require("../controllers/testuser.controllers");
const express = require('express');
const router = express.Router();

router.get('/', writerPage)

module.exports = router;