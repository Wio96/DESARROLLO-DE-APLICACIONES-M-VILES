const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./User');

const Plant = sequelize.define('Plant', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  scientificName: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  category: {
    // Cambiado a STRING para que encaje perfecto con el VARCHAR(100) de tu base de datos
    type: DataTypes.STRING,
    allowNull: false,
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  latitude: {
    type: DataTypes.FLOAT,
    allowNull: true,
  },
  longitude: {
    type: DataTypes.FLOAT,
    allowNull: true,
  },
  userId: {
    type: DataTypes.UUID,
    allowNull: false,
  }
}, {
  // Aquí está la clave principal: apuntar a la tabla correcta
  tableName: 'plants',
  timestamps: true,
});

// Relaciones: Un técnico puede registrar muchas plantas en los monitoreos territoriales
User.hasMany(Plant, { foreignKey: 'userId', as: 'registros' });
Plant.belongsTo(User, { foreignKey: 'userId', as: 'tecnico' });

module.exports = Plant;