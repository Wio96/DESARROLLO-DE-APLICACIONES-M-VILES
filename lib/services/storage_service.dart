import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database/database.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();
  final String _jwtKey = 'biosacha_jwt_token';

  // Guarda el token en la bóveda tras un login exitoso
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _jwtKey, value: token);
  }

  // Recupera el token para mantener la sesión al reabrir la app
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _jwtKey);
  }

  // Limpieza completa exigida al cerrar sesión (Token + Caché local Drift)
  Future<void> clearAll(AppDatabase db) async {
    // 1. Borra las credenciales cifradas
    await _secureStorage.deleteAll();

    // 2. Destruye los registros locales y la cola de pendientes
    await db.delete(db.registrosCampo).go();
    await db.delete(db.operacionesPendientes).go();
  }
}
