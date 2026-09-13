const bcrypt = require('bcrypt');
// Aquí importas tu conexión a la base de datos o modelo de Sequelize/MariaDB
const { User } = require('./index'); // Ajusta según tu estructura

async function resetAdmin() {
  const nuevaClavePlana = "123456";
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(nuevaClavePlana, salt);

  // Actualiza en la base de datos buscando por tu correo de administrador
  await User.update(
    { password: hashedPassword },
    { where: { email: 'tu_correo_admin_anterior@biosacha.com' } }
  );

  console.log("¡Contraseña de admin restablecida con éxito a '123456'!");
}

resetAdmin();