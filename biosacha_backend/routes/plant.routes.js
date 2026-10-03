// routes/plant.routes.js
const express = require('express');
const router = express.Router();
const plantController = require('../controllers/plant.controller');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// SOLUCIÓN PARA RENDER: Asegurar que la carpeta 'uploads' exista ANTES de que Multer actúe
const uploadDir = path.join(__dirname, '../uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

// Configuración de Multer para guardar las fotos
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); 
  },
  filename: (req, file, cb) => {
    // Genera un nombre único: foto_16900000000.jpg
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'foto_' + uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

router.get('/', plantController.getAllPlants);

// Multer interceptará el archivo enviado con el nombre 'foto'
router.post('/', upload.single('foto'), plantController.createPlant);

router.put('/:id', upload.single('foto'), plantController.updatePlant);
router.delete('/:id', plantController.deletePlant);

module.exports = router;