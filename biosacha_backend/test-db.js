// test-db.js
const sequelize = require('./config/database'); // Ajusta la ruta si 'database.js' está en otra carpeta

async function verificarConexion() {
  try {
    await sequelize.authenticate();
    console.log('✅ ¡Conexión establecida con éxito a MySQL!');
  } catch (error) {
    console.error('❌ No se pudo conectar a la base de datos:', error.message);
  } finally {
    process.exit(); // Esto cierra la prueba automáticamente
  }
}

verificarConexion();