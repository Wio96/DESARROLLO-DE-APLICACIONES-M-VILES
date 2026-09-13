const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');

router.post('/register', authController.register);
router.post('/login', authController.login); // Esta es la ruta indispensable
router.get('/', authController.getAllUsers);

module.exports = router;