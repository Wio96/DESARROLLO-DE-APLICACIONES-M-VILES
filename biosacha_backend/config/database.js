// config/database.js
const { Sequelize } = require('sequelize');

// Si estamos en la nube, lee las variables de entorno; si no, usa tus datos locales
const sequelize = new Sequelize(
  process.env.DB_NAME || 'biosacha',
  process.env.DB_USER || 'root',
  process.env.DB_PASSWORD || '',
  {
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT ? Number(process.env.DB_PORT) : 3306,
    dialect: 'mysql',
    logging: false,
    dialectOptions: {
      ssl: process.env.DB_SSL === 'true' ? { rejectUnauthorized: false } : false
    }
  }
);

module.exports = sequelize;