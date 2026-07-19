const User = require('../models/User');
const bcrypt = require('bcryptjs');

exports.register = async (req, res) => {
    try {
        const { email, password, role } = req.body;
        
        // Ciframos la contraseña
        const hashedPassword = await bcrypt.hash(password, 10);
        
        // Creamos el usuario
        const newUser = await User.create({
            email,
            password: hashedPassword,
            role: role || 'tecnico'
        });
        
        res.status(201).json({ message: 'Usuario registrado con éxito', userId: newUser.id });
    } catch (error) {
        res.status(400).json({ error: 'Error al registrar usuario: ' + error.message });
    }
}; // <-- ¡Esta llave cierra register!

exports.getAllUsers = async (req, res) => {
    try {
        const users = await User.findAll();
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener usuarios' });
    }
}; // <-- Esta llave cierra getAllUsers