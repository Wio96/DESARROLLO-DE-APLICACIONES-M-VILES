const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken'); // Necesario para crear el token de sesión

exports.register = async (req, res) => {
    try {
        // 1. Recibimos todos los campos que exige tu modelo
        const { nombre, email, password, rol } = req.body;
        
        if (!nombre) {
            return res.status(400).json({ error: 'El nombre es obligatorio' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        
        // 2. Creamos el usuario respetando los nombres de tu tabla
        const newUser = await User.create({
            nombre: nombre,
            email: email,
            password: hashedPassword,
            rol: rol || 'VISITANTE' // Asigna VISITANTE por defecto si no se envía
        });
        
        res.status(201).json({ message: 'Usuario registrado con éxito', userId: newUser.id });
    } catch (error) {
        res.status(400).json({ error: 'Error al registrar usuario: ' + error.message });
    }
};

// 3. LA FUNCIÓN FALTANTE: Iniciar sesión y enviar el rol
exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ where: { email } });
        if (!user) {
            return res.status(404).json({ error: 'Usuario no encontrado' });
        }

        const validPassword = await bcrypt.compare(password, user.password);
        if (!validPassword) {
            return res.status(401).json({ error: 'Contraseña incorrecta' });
        }

        // Generamos el ticket de acceso
        const token = jwt.sign(
            { id: user.id, rol: user.rol }, 
            'biosacha_secreto_123', 
            { expiresIn: '24h' }
        );

        // 4. Respondemos a Flutter enviando el ROL exacto del usuario
        res.status(200).json({
            message: 'Inicio de sesión exitoso',
            token: token,
            user: {
                id: user.id,
                name: user.nombre, 
                email: user.email,
                rol: user.rol // AQUÍ VIAJA EL ROL (ADMIN, TECNICO, VISITANTE)
            }
        });
    } catch (error) {
        res.status(500).json({ error: 'Error en el servidor al iniciar sesión' });
    }
};

exports.getAllUsers = async (req, res) => {
    try {
        const users = await User.findAll();
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener usuarios' });
    }
};