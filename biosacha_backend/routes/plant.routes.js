// routes/plant.routes.js
const express = require('express');
const router = express.Router();
const plantController = require('../controllers/plant.controller');
const multer = require('multer');
const path = require('path');

// Configuración de Multer para guardar las fotos en la carpeta 'uploads'
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // Asegúrate de tener una carpeta llamada 'uploads' en la raíz de tu proyecto
  },
  filename: (req, file, cb) => {
    // Genera un nombre único: foto_16900000000.jpg
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'foto_' + uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

router.get('/', plantController.getAllPlants);

// CAMBIO CRÍTICO: Agregamos 'upload.single('foto')' para que intercepte la imagen adjunta
router.post('/', upload.single('foto'), plantController.createPlant);

router.put('/:id', upload.single('foto'), plantController.updatePlant);
router.delete('/:id', plantController.deletePlant);

module.exports = router;