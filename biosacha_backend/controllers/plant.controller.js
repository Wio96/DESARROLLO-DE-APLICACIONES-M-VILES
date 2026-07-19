const Plant = require('../models/Plant');
const User = require('../models/User');
const NodeCache = require('node-cache');
const myCache = new NodeCache({ stdTTL: 60 });

exports.getAllPlants = async (req, res) => {
    try {
        const cacheKey = 'all_plants';

        if (myCache.has(cacheKey)) {
            console.log('📦 Sirviendo desde Caché');
            return res.status(200).json(myCache.get(cacheKey));
        }

        console.log('💾 Consultando Base de Datos...');
        const plants = await Plant.findAll({
            include: [{ model: User, attributes: ['email', 'role'] }]
        });

        // AQUÍ ESTÁ LA MODIFICACIÓN:
        // Convertimos los modelos de Sequelize a objetos planos (JSON)
        const plantsJson = plants.map(p => p.toJSON());

        // Guardamos los objetos planos en la caché
        myCache.set(cacheKey, plantsJson);
        
        console.log('💾 Guardado en Caché');
        return res.status(200).json(plantsJson);

    } catch (error) {
        console.error("❌ ERROR CRÍTICO:", error);
        return res.status(500).json({ error: error.message });
    }
};

exports.createPlant = async (req, res) => {
    try {
        // 1. Creamos la planta
        const newPlant = await Plant.create(req.body);
        
        // 2. Invalidamos el caché
        myCache.del('all_plants');

        // 3. RESPONDEMOS AL CLIENTE (Esto debe ir primero)
        res.status(201).json(newPlant);

        // 4. EL WORKER (Simulación asíncrona)
        // Usamos setTimeout para simular un proceso pesado que tarda 3 segundos
        setTimeout(() => {
            console.log("[Worker] Reporte técnico generado...");
        }, 3000); 

    } catch (error) {
        return res.status(400).json({ error: error.message });
    }
};