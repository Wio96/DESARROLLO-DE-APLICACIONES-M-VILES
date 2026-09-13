const express = require('express');
const cors = require('cors');
const path = require('path');
const sequelize = require('./config/database');
const User = require('./models/User');
const Plant = require('./models/Plant');
const PlantPhoto = require('./models/PlantPhoto'); // <--- Nuevo modelo de fotos
const authRoutes = require('./routes/auth.routes');
const plantRoutes = require('./routes/plant.routes');

const app = express();

// Middlewares esenciales
app.use(cors());
app.use(express.json());

// Middleware espía para rastrear peticiones entrantes desde el emulador
app.use((req, res, next) => {
  console.log(`👀 ALGUIEN TOCA LA PUERTA: ${req.method} a la ruta ${req.url}`);
  next();
});

// Hacer pública la carpeta 'uploads' para acceder a las fotos vía URL (ej: http://localhost:3000/uploads/foto.jpg)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Rutas de la API
app.use('/api/auth', authRoutes);
app.use('/api/plants', plantRoutes);

// Prueba de ruta simple
app.get('/prueba-ruta', (req, res) => {
    console.log("¡Llegó la prueba!");
    res.send("Funciona");
});

// Definición de Relaciones (Sequelize)
User.hasMany(Plant, { foreignKey: 'userId' });
Plant.belongsTo(User, { foreignKey: 'userId' });

Plant.hasMany(PlantPhoto, { foreignKey: 'plantId', onDelete: 'CASCADE' });
PlantPhoto.belongsTo(Plant, { foreignKey: 'plantId' });

// Sincronización y Encendido del Servidor
// CAMBIO CLAVE: alter: true obliga a MariaDB a aplicar los cambios del modelo (Auto Increment)
sequelize.sync({ alter: true }) 
  .then(() => {
    console.log('✅ Base de datos sincronizada y estructura actualizada correctamente');
    
    app.listen(3000, '0.0.0.0', () => {
      console.log('🚀 Servidor corriendo en el puerto 3000');
    });
  })
  .catch(err => {
    console.error('❌ Error al sincronizar la base de datos:', err);
  });