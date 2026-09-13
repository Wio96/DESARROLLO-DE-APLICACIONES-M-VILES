const sequelize = require('./config/database');
const User = require('./models/User');
const bcrypt = require('bcryptjs');

async function inyectarUsuario() {
  try {
    await sequelize.authenticate();
    const hashedPassword = await bcrypt.hash('123456', 10);
    
    await User.create({
      nombre: 'Wio Gualinga',
      email: 'wio@biosacha.com',
      password: hashedPassword,
      rol: 'ADMIN'
    });
    
    console.log('✅ Usuario administrador inyectado con éxito en la tabla usuarios.');
    process.exit();
  } catch (error) {
    console.error('❌ Error:', error);
    process.exit(1);
  }
}

inyectarUsuario();