const express = require('express');
const router = express.Router();
const plantController = require('../controllers/plant.controller');

router.post('/', plantController.createPlant); // Registrar planta
router.get('/', plantController.getAllPlants);  // Listar plantas

module.exports = router;