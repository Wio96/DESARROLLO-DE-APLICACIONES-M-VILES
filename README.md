royecto Biosacha - Taller Práctico Semana 9
Repositorio del proyecto integrador correspondiente al entorno de desarrollo móvil y conectividad con la API del backend.

🛠️ Tecnologías y Versiones Utilizadas
Backend: Node.js (v24+), Express, Sequelize, SQLite/PostgreSQL.

Frontend / Móvil: Flutter (v3.44.4), Dart (v3.12.2).

Entorno de ejecución: Google Chrome (como destino multiplataforma web por optimización de recursos).

🚀 Pasos de Configuración y Ejecución
Para reproducir este entorno de desarrollo localmente, siga los pasos a continuación:

1. Clonar el repositorio
Bash
git clone <URL_DE_TU_REPOSITORIO>
cd biosacha
2. Configurar y Ejecutar el Backend (Node.js)
Ingrese a la carpeta del servidor:

Bash
cd biosacha_backend
Instale las dependencias necesarias (incluyendo cors y express):

Bash
npm install
Encienda el servidor:

Bash
node index.js
El servidor quedará activo en http://localhost:3000.

3. Configurar y Ejecutar la Aplicación (Flutter)
Abra otra terminal y regrese a la raíz del proyecto o ingrese a la carpeta de Flutter:

Bash
cd ..
Instale las dependencias del proyecto móvil:

Bash
flutter pub get
Ejecute el comando de diagnóstico para verificar el entorno:

Bash
flutter doctor -v
Ejecute la aplicación apuntando hacia el entorno de desarrollo web (Chrome):

Bash
flutter run -d chrome
🔌 Verificación de Conectividad
La aplicación móvil se conecta mediante solicitudes HTTP GET hacia el endpoint local de la API (http://localhost:3000/api/plants). Se configuró el middleware cors en el servidor Node.js para permitir la comunicación correcta desde el navegador y el frontend.