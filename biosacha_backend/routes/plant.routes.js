// routes/plant.routes.js
const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const Plant = require('../models/Plant');
const PlantPhoto = require('../models/PlantPhoto');

// Configurar carpeta uploads física en la raíz del backend
const uploadDir = path.join(__dirname, '../uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

const storageConfig = multer.diskStorage({
    destination: (req, file, cb) => cb(null, uploadDir),
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, 'plant_' + uniqueSuffix + path.extname(file.originalname));
    }
});
const upload = multer({ storage: storageConfig });

// 1. RUTA PARA GUARDAR LOS DATOS DE TEXTO DE LA PLANTA
router.post('/', async (req, res) => {
    try {
        const { id, name, scientificName, description, latitude, longitude, category, userId } = req.body;

        // Preparamos los datos limpios sin inyectar un ID vacío
        const plantData = {
            name,
            scientificName,
            description,
            latitude,
            longitude,
            category,
            userId
        };
        
        // Solo agregamos el ID si Flutter lo envió (para actualizar)
        if (id) {
            plantData.id = id;
        }

        // Crear la planta como un registro completamente nuevo
        const plant = await Plant.create(plantData);

        res.status(201).json({ 
            message: 'Planta sincronizada con éxito 🌿', 
            plant: {
                id: plant.id
            } 
        });
    } catch (error) {
        console.error('Error al guardar la planta:', error);
        res.status(500).json({ error: 'Error al guardar los datos de la planta en la base de datos' });
    }
});

// 2. RUTA PARA RECIBIR Y GUARDAR LA FOTO ASOCIADA A UNA PLANTA
router.post('/photo', upload.single('photo'), async (req, res) => {
    try {
        const { plantId } = req.body;

        if (!req.file) {
            return res.status(400).json({ error: 'No se ha adjuntado ninguna imagen' });
        }

        const photoUrl = `/uploads/${req.file.filename}`;

        const nuevaFoto = await PlantPhoto.create({
            plantId,
            photoUrl
        });

        res.status(201).json({
            message: 'Fotografía guardada y vinculada con éxito 📸',
            photo: nuevaFoto
        });
    } catch (error) {
        console.error('Error al guardar la foto:', error);
        res.status(500).json({ error: 'Error interno al guardar la fotografía' });
    }
});

module.exports = router;