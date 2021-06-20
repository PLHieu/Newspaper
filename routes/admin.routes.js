const { adminPage } = require("../controllers/testuser.controllers");
const express = require('express');
const router = express.Router();

router.get('/', adminPage);

module.exports = router;