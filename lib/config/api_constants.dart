// lib/config/api_constants.dart
class ApiConstants {
  // Constante de compilación para definir el ambiente (por defecto 'dev')
  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');

  // Dirección base dinámica según el ambiente
  static String get baseUrl {
    if (env == 'prod') {
      // Exigencia de la rúbrica: HTTPS en producción
      return 'https://api.biosacha.com/api';
    }
    // Ambiente de desarrollo (dev) - Ajusta tu IP si pruebas en dispositivo físico
    return 'http://192.168.1.42:3000/api';
  }

  // Tiempos de espera explícitos
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
