const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Plant = sequelize.define('Plant', {
  name: { type: DataTypes.STRING, allowNull: false },
  scientificName: { type: DataTypes.STRING, allowNull: true },
  description: { type: DataTypes.TEXT, allowNull: true },
  category: { 
    type: DataTypes.ENUM('medicinal', 'frutal', 'maderable'), 
    allowNull: false 
  },
  // AGREGA ESTA LÍNEA:
  userId: { 
    type: DataTypes.INTEGER, 
    allowNull: true // Ponlo en true temporalmente para no borrar tus plantas actuales
  }
});

module.exports = Plant;