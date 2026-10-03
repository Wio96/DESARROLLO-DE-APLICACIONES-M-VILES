// controllers/plant.controller.js
const Plant = require('../models/Plant');
const User = require('../models/User');
const PlantPhoto = require('../models/PlantPhoto');
const NodeCache = require('node-cache');
const myCache = new NodeCache({ stdTTL: 60 });
const fs = require('fs');
const path = require('path');

exports.getAllPlants = async (req, res) => {
    try {
        const categoryFilter = req.query.category;
        const cacheKey = categoryFilter ? `plants_cat_${categoryFilter}` : 'all_plants';

        if (myCache.has(cacheKey)) {
            console.log(`📦 Sirviendo desde Caché (${cacheKey})`);
            return res.status(200).json(myCache.get(cacheKey));
        }

        console.log('💾 Consultando Base de Datos...');
        const whereCondition = categoryFilter ? { category: categoryFilter } : {};

        const plants = await Plant.findAll({
            where: whereCondition,
            include: [{ model: User, attributes: ['email', 'rol'] }]
        });

        const plantsJson = plants.map(p => p.toJSON());

        myCache.set(cacheKey, plantsJson);
        return res.status(200).json(plantsJson);

    } catch (error) {
        console.error("❌ ERROR CRÍTICO:", error);
        return res.status(500).json({ error: error.message });
    }
};

exports.createPlant = async (req, res) => {
    try {
        if (req.body.name === 'Planta Prohibida') {
            return res.status(422).json({
                error: 'El nombre de esta especie no está permitido en el registro territorial.'
            });
        }

        // Asegurar que la carpeta uploads exista físicamente
        const uploadDir = path.join(__dirname, '../uploads');
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir, { recursive: true });
        }

        // Armamos el objeto con los datos que llegaron del formulario
        const plantData = {
            name: req.body.name,
            scientificName: req.body.scientificName,
            description: req.body.description,
            category: req.body.category,
            latitude: req.body.latitude,
            longitude: req.body.longitude,
            userId: req.body.userId,
        };

        // INTEGRACIÓN MULTER: Si el usuario envió una foto correctamente
        if (req.file) {
            const serverUrl = `${req.protocol}://${req.get('host')}`;
            plantData.fotografiaUrl = `${serverUrl}/uploads/${req.file.filename}`;
            console.log("📸 Foto procesada y guardada:", plantData.fotografiaUrl);
        } else {
            console.log("⚠️ Advertencia: No se recibió ningún archivo adjunto en la petición.");
        }

        const newPlant = await Plant.create(plantData);
        myCache.flushAll(); 
        
        // Devolvemos la planta creada con su ID para que Flutter lo lea sin errores
        return res.status(201).json(newPlant);
        
    } catch (error) {
        console.error("❌ Error detallado guardando planta:", error);
        return res.status(400).json({ error: error.message });
    }
};

exports.updatePlant = async (req, res) => {
    try {
        const { id } = req.params;
        const updateData = { ...req.body };

        if (req.file) {
            const serverUrl = `${req.protocol}://${req.get('host')}`;
            updateData.fotografiaUrl = `${serverUrl}/uploads/${req.file.filename}`;
        }

        const updated = await Plant.update(updateData, { where: { id } });
        
        if (updated[0] === 0) {
            return res.status(404).json({ error: 'Planta no encontrada' });
        }

        myCache.flushAll(); 
        return res.status(200).json({ message: 'Planta actualizada correctamente 🌿' });
    } catch (error) {
        console.error("❌ Error actualizando planta:", error);
        return res.status(500).json({ error: error.message });
    }
};

exports.deletePlant = async (req, res) => {
    try {
        const { id } = req.params;
        const deleted = await Plant.destroy({ where: { id } });
        
        if (!deleted) {
            return res.status(404).json({ error: 'Plans no encontrada' });
        }

        myCache.flushAll(); 
        return res.status(200).json({ message: 'Planta eliminada permanentemente 🗑️' });
    } catch (error) {
        console.error("❌ Error eliminando planta:", error);
        return res.status(500).json({ error: error.message });
    }
};