// lib/config/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_constants.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Dio
  _dioForRefresh; // Instancia secundaria solo para renovar y evitar bucles

  AuthInterceptor(this._dioForRefresh);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Inyectar el token leído del almacenamiento cifrado
    final token = await _storage.read(key: 'jwt_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 2. Interceptar el error 401 (No Autorizado / Token Expirado)
    if (err.response?.statusCode == 401) {
      // 3. Protección contra bucles infinitos (Requisito de la rúbrica)
      if (err.requestOptions.extra['isRetry'] == true) {
        return handler.next(err); // Si ya lo intentamos y falló, nos rendimos.
      }
      err.requestOptions.extra['isRetry'] = true;

      try {
        // 4. Intentar renovar el token
        final newToken = await _refreshToken();

        if (newToken != null) {
          // Guardar el nuevo token en la bóveda
          await _storage.write(key: 'jwt_token', value: newToken);

          // Actualizar la petición original con el nuevo token
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

          // 5. Reintentar la petición original de forma transparente
          final response = await _dioForRefresh.fetch(err.requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
        // Si falla la renovación, dejamos pasar el error para que la capa visual exija re-login
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  // Método auxiliar para pedir el nuevo token al backend
  Future<String?> _refreshToken() async {
    try {
      final userId = await _storage.read(key: 'userId');
      if (userId == null) return null;

      // NOTA: Ajusta '/auth/refresh' según la ruta real que maneje tu backend en Node.js
      final response = await _dioForRefresh.post(
        '${ApiConstants.baseUrl}/auth/refresh',
        data: {'userId': userId},
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
