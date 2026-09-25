// lib/config/api_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Para kDebugMode
import 'api_constants.dart';
import 'auth_interceptor.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        contentType: 'application/json',
      ),
    );

    // Creamos una instancia clonada solo para las renovaciones de token
    // Esto evita que la petición de renovación sea interceptada y cause un bucle infinito
    final dioForRefresh = Dio(dio.options);

    // ORDEN DE LOS INTERCEPTORES (Requisito del taller)
    // 1. AuthInterceptor: Primero inyecta credenciales o frena la petición si renueva.
    dio.interceptors.add(AuthInterceptor(dioForRefresh));

    // 2. Logging: Solo imprime en consola si estamos en desarrollo (kDebugMode)
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          responseHeader: false,
          requestBody: true,
          responseBody: true,
          // Ocultar la clave secreta del encabezado de autorización
          request: true,
          logPrint: (object) {
            String logMessage = object.toString();
            // Filtro de seguridad para no imprimir el token JWT en la consola
            if (logMessage.contains('Authorization:')) {
              logMessage = logMessage.replaceAll(
                RegExp(r'Bearer [a-zA-Z0-9\-\._~+/]+=*'),
                'Bearer [OCULTO_POR_SEGURIDAD]',
              );
            }
            debugPrint(logMessage);
          },
        ),
      );
    }
  }

  factory ApiClient() {
    return _instance;
  }
}
