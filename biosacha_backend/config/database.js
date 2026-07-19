// config/database.js
const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('biosacha_db', 'root', '123456', {
  host: 'localhost',
  dialect: 'mysql', // <--- ¡Aquí faltaba la coma!
  logging: false
});

module.exports = sequelize;