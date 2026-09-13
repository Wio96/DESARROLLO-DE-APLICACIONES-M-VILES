import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database/database.dart';
import 'storage_service.dart';
import '../config/api_constants.dart';

class SyncService {
  final AppDatabase db;
  final _secureStorage = const FlutterSecureStorage();

  SyncService(this.db);

  // Devuelve la cantidad de registros sincronizados para avisarle a la UI
  Future<int> procesarColaSalida() async {
    int sincronizados = 0;
    final storage = StorageService();

    // 1. Obtenemos el token usando la calse storgate_service.dart para mantener la secion activa y cumplir con la seguridad JWT
    final token = await storage.getToken();

    // Obtenemos el userId para cumplir con tu llave foránea en MariaDB
    final userId =
        await _secureStorage.read(key: 'userId') ??
        await _secureStorage.read(key: 'id') ??
        await _secureStorage.read(key: 'user_id') ??
        '1';

    // 2. Buscamos las plantas guardadas offline en la tabla correcta (registrosCampo)
    final pendientes = await (db.select(
      db.registrosCampo,
    )..where((tbl) => tbl.sincronizado.equals(false))).get();

    if (pendientes.isEmpty) return 0;

    for (final planta in pendientes) {
      final payload = {
        'name': planta.nombreEspecie,
        'scientificName': 'Registro en territorio',
        'description': 'Guardado offline',
        'category': 'Medicinal',
        'latitude': planta.latitud,
        'longitude': planta.longitud,
        'userId': userId,
      };

      // 3. Intentamos conectar. Si el servidor de Node.js está apagado, lanza error a los 5s
      final response = await http
          .post(
            Uri.parse('${ApiConstants.baseUrl}/plants'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 5));

      // 4. Si MariaDB lo acepta, actualizamos la tabla para que la UI se pinte de verde
      if (response.statusCode == 201 || response.statusCode == 200) {
        await (db.update(db.registrosCampo)
              ..where((tbl) => tbl.id.equals(planta.id)))
            .write(const RegistrosCampoCompanion(sincronizado: Value(true)));
        sincronizados++;
      } else {
        throw Exception('Rechazo del servidor: Código ${response.statusCode}');
      }
    }

    return sincronizados;
  }
}
