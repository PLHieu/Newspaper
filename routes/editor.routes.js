const { editorPage } = require("../controllers/testuser.controllers");
const express = require('express');
const router = express.Router();

router.get('/', editorPage)

module.exports = router;