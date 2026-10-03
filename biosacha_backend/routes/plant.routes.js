// routes/plant.routes.js
const express = require('express');
const router = express.Router();
const plantController = require('../controllers/plant.controller');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const uploadDir = path.join(__dirname, '../uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir); // <-- FIX: Usar la ruta absoluta segura
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'foto_' + uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

router.get('/', plantController.getAllPlants);
router.post('/', upload.single('foto'), plantController.createPlant);
router.put('/:id', upload.single('foto'), plantController.updatePlant);
router.delete('/:id', plantController.deletePlant);

module.exports = router;