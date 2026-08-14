// index.js
const express = require('express');
const cors = require('cors'); // <--- ¡Aquí está la pieza clave que faltaba!
const sequelize = require('./config/database');
const User = require('./models/User');
const Plant = require('./models/Plant');
const authRoutes = require('./routes/auth.routes');
const plantRoutes = require('./routes/plant.routes');

const app = express();

// Middlewares esenciales
app.use(cors()); // <--- Activado para que Chrome no bloquee las peticiones
app.use(express.json());

// Rutas
app.use('/api/auth', authRoutes);

// Prueba de ruta simple
app.get('/prueba-ruta', (req, res) => {
    console.log("¡Llegó la prueba!");
    res.send("Funciona");
});

app.use('/api/plants', plantRoutes);

// Relaciones
User.hasMany(Plant, { foreignKey: 'userId' });
Plant.belongsTo(User, { foreignKey: 'userId' });

// Sincronización y Encendido del Servidor
sequelize.sync({ force: false }) 
  .then(() => {
    console.log('✅ Base de datos sincronizada');
    
    app.listen(3000, () => {
      console.log('🚀 Servidor corriendo en el puerto 3000');
    });
  })
  .catch(err => {
    console.error('❌ Error:', err);
  });