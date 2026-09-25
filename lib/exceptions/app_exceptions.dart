// lib/exceptions/app_exceptions.dart
import 'package:dio/dio.dart';

class AppExceptions {
  static String getErrorMessage(DioException error) {
    switch (error.type) {
      // 1. Familia: Tiempos de espera (Timeout)
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Tiempo de espera agotado. La conexión es muy lenta.";

      // 2. Familia: Fallo de red / Sin internet
      case DioExceptionType.connectionError:
        return "Sin conexión a internet. Cambiando a modo offline.";

      // 3 y 4. Familia: Errores del Servidor (500) y de Validación (422)
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        if (statusCode == 422) {
          // Errores de validación de campos desde el backend
          return "Datos inválidos: ${error.response?.data['error'] ?? 'Revisa los campos'}";
        }
        if (statusCode == 401) {
          return "Tu sesión ha expirado.";
        }
        if (statusCode != null && statusCode >= 500) {
          return "Error interno del servidor. Intenta más tarde.";
        }
        return "Ocurrió un error inesperado ($statusCode).";

      default:
        return "Error desconocido al intentar conectar.";
    }
  }
}
