const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');

router.post('/register', authController.register);
router.post('/login', authController.login); 
router.get('/users', authController.getAllUsers);

// NUEVA RUTA: Recibe el ID del usuario en la URL para actualizar su rol
router.put('/users/:id/role', authController.updateUserRole);

module.exports = router;