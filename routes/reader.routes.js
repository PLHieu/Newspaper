const { SubcriberPage } = require("../controllers/testuser.controllers");
const authentication = require('../controllers/authen.controllers')
const express = require('express');
const router = express.Router();

router.get('/', SubcriberPage)
router.get('/editprofile', authentication.getEditProfileView);
router.put('/password', authentication.changePassword);
router.put('/profile',  authentication.updateProfile);
router.get('/subPremium',  authentication.subcribePremium);

module.exports = router;