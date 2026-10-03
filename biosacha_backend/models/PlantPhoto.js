const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const PlantPhoto = sequelize.define('PlantPhoto', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    plantId: {
        // ¡Cambiado a INTEGER para que coincida con el id de Plantas!
        type: DataTypes.INTEGER,
        allowNull: false
    },
    photoUrl: {
        type: DataTypes.STRING(255),
        allowNull: false
    }
}, {
    tableName: 'plant_photos',
    timestamps: true,
    updatedAt: false // Como la tabla solo tiene createdAt
});

module.exports = PlantPhoto;