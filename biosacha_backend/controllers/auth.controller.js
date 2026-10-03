const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken'); 

exports.register = async (req, res) => {
    try {
        // Ignoramos el rol que envíe el usuario desde el formulario
        const { nombre, email, password } = req.body;
        
        if (!nombre) {
            return res.status(400).json({ error: 'El nombre es obligatorio' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        
        // REGLA DE ORO: Todo usuario nuevo nace como visitante
        const newUser = await User.create({
            nombre: nombre,
            email: email,
            password: hashedPassword,
            rol: 'visitante' 
        });
        
        res.status(201).json({ message: 'Usuario registrado con éxito', userId: newUser.id });
    } catch (error) {
        res.status(400).json({ error: 'Error al registrar usuario: ' + error.message });
    }
};

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

        const token = jwt.sign(
            { id: user.id, rol: user.rol }, 
            'biosacha_secreto_123', 
            { expiresIn: '1m' }
        );

        res.status(200).json({
            message: 'Inicio de sesión exitoso',
            token: token,
            user: {
                id: user.id,
                name: user.nombre, 
                email: user.email,
                rol: user.rol 
            }
        });
    } catch (error) {
        res.status(500).json({ error: 'Error en el servidor al iniciar sesión' });
    }
};

exports.getAllUsers = async (req, res) => {
    try {
        const users = await User.findAll({
            attributes: ['id', 'nombre', 'email', 'rol'] 
        });
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener usuarios' });
    }
};

// NUEVA FUNCIÓN: Permite cambiar el rol de un usuario
exports.updateUserRole = async (req, res) => {
    try {
        const { id } = req.params;
        const { rol } = req.body;

        // Validamos que sea un rol permitido
        const validRoles = ['admin', 'tecnico', 'visitante'];
        if (!validRoles.includes(rol.toLowerCase())) {
            return res.status(400).json({ error: 'Rol inválido' });
        }

        const user = await User.findByPk(id);
        if (!user) {
            return res.status(404).json({ error: 'Usuario no encontrado' });
        }

        user.rol = rol.toLowerCase();
        await user.save();

        res.status(200).json({ message: 'Rol actualizado exitosamente', user });
    } catch (error) {
        res.status(500).json({ error: 'Error al actualizar el rol' });
    }
};