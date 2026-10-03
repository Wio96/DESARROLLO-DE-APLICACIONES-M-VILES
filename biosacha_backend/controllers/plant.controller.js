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

        // 1. Buscamos todas las plantas
        const plants = await Plant.findAll({
            where: whereCondition,
            include: [{ model: User, attributes: ['email', 'rol'] }]
        });

        // 2. MÉTODO SEGURO: Buscamos la foto correspondiente a cada planta en la tabla plant_photos
        const plantsJson = [];
        for (let p of plants) {
            const plant = p.toJSON();
            
            // Buscamos si esta planta tiene una foto guardada
            const photo = await PlantPhoto.findOne({ where: { plantId: plant.id } });
            
            // Si encontramos la foto, se la asignamos a 'fotografiaUrl' para que Flutter la lea
            plant.fotografiaUrl = photo ? photo.photoUrl : null;
            
            plantsJson.push(plant);
        }

        myCache.set(cacheKey, plantsJson);
        return res.status(200).json(plantsJson);

    } catch (error) {
        console.error("❌ ERROR CRÍTICO obteniendo plantas:", error);
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

        // 1. Armamos SOLAMENTE los datos de la planta (sin la foto)
        const plantData = {
            name: req.body.name,
            scientificName: req.body.scientificName,
            description: req.body.description,
            category: req.body.category,
            latitude: req.body.latitude,
            longitude: req.body.longitude,
            userId: req.body.userId,
        };

        // 2. Guardamos la planta en la tabla 'plants'
        const newPlant = await Plant.create(plantData);

        // 3. Si viene una foto, la guardamos en la tabla 'plant_photos'
        if (req.file) {
            const serverUrl = `${req.protocol}://${req.get('host')}`;
            const urlDeLaFoto = `${serverUrl}/uploads/${req.file.filename}`;
            
            await PlantPhoto.create({
                plantId: newPlant.id,
                photoUrl: urlDeLaFoto
            });
            console.log("📸 Foto procesada y guardada en plant_photos:", urlDeLaFoto);
        } else {
            console.log("⚠️ Advertencia: No se recibió ningún archivo adjunto en la petición.");
        }

        myCache.flushAll(); 
        
        // Devolvemos la planta creada con su ID
        return res.status(201).json(newPlant);
        
    } catch (error) {
        console.error("❌ Error detallado guardando planta:", error);
        return res.status(500).json({ error: error.message }); 
    }
};

exports.updatePlant = async (req, res) => {
    try {
        const { id } = req.params;
        const updateData = { ...req.body };

        const updated = await Plant.update(updateData, { where: { id } });
        
        if (updated[0] === 0) {
            return res.status(404).json({ error: 'Planta no encontrada' });
        }

        // Si envió una foto nueva al editar, la actualizamos o creamos en plant_photos
        if (req.file) {
            const serverUrl = `${req.protocol}://${req.get('host')}`;
            const urlDeLaFoto = `${serverUrl}/uploads/${req.file.filename}`;
            
            const existingPhoto = await PlantPhoto.findOne({ where: { plantId: id } });
            
            if (existingPhoto) {
                await existingPhoto.update({ photoUrl: urlDeLaFoto });
            } else {
                await PlantPhoto.create({ plantId: id, photoUrl: urlDeLaFoto });
            }
            console.log("📸 Foto actualizada en plant_photos:", urlDeLaFoto);
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
        
        // Primero eliminamos la foto asociada para evitar errores
        await PlantPhoto.destroy({ where: { plantId: id } });
        
        // Luego eliminamos la planta
        const deleted = await Plant.destroy({ where: { id } });
        
        if (!deleted) {
            return res.status(404).json({ error: 'Planta no encontrada' });
        }

        myCache.flushAll(); 
        return res.status(200).json({ message: 'Planta eliminada permanentemente 🗑️' });
    } catch (error) {
        console.error("❌ Error eliminando planta:", error);
        return res.status(500).json({ error: error.message });
    }
};