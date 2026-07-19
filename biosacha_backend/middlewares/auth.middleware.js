const jwt = require('jsonwebtoken');

const verificarToken = (req, res, next) => {
    // 1. Obtener el token del encabezado (Authorization: Bearer <token>)
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    // 2. Si no hay token, responder 401 Unauthorized
    if (!token) {
        return res.status(401).json({ message: 'Acceso denegado: Token no proporcionado' });
    }

    try {
        // 3. Verificar el token usando tu clave secreta (definida en .env)
        const verified = jwt.verify(token, process.env.JWT_SECRET || 'secreto_temporal');
        req.user = verified; // Guardamos los datos del usuario en la petición
        next(); // Todo bien, pasamos a la siguiente función
    } catch (err) {
        // 4. Si el token es inválido o expiró, responder 401
        res.status(401).json({ message: 'Acceso denegado: Token inválido o expirado' });
    }
};

module.exports = { verificarToken };