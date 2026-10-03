// lib/services/sync_service.dart
import 'dart:io';
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

  Future<int> procesarColaSalida() async {
    int sincronizados = 0;
    final storage = StorageService();

    final token = await storage.getToken();

    final userId =
        await _secureStorage.read(key: 'userId') ??
        await _secureStorage.read(key: 'id') ??
        await _secureStorage.read(key: 'user_id') ??
        '1';

    final pendientes = await (db.select(
      db.registrosCampo,
    )..where((tbl) => tbl.sincronizado.equals(false))).get();

    if (pendientes.isEmpty) return 0;

    for (final planta in pendientes) {
      // 1. Creamos una petición "Multipart" que permite adjuntar archivos
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.baseUrl}/plants'),
      );

      // 2. Adjuntamos las cabeceras de seguridad
      request.headers.addAll({'Authorization': 'Bearer $token'});

      // 3. Adjuntamos los datos de texto de la planta
      request.fields['name'] = planta.nombreEspecie;
      request.fields['scientificName'] = 'Registro en territorio';
      request.fields['description'] = 'Guardado offline';
      request.fields['category'] = 'Medicinal';
      request.fields['latitude'] = planta.latitud?.toString() ?? '-1.5000';
      request.fields['longitude'] = planta.longitud?.toString() ?? '-77.9000';
      request.fields['userId'] = userId;

      // 4. Si la planta tiene una foto guardada en el celular, la adjuntamos al envío
      if (planta.fotografiaUrl != null && planta.fotografiaUrl!.isNotEmpty) {
        File imageFile = File(planta.fotografiaUrl!);
        if (imageFile.existsSync()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'foto', // Este nombre debe coincidir con el 'upload.single("foto")' de Node.js
              imageFile.path,
            ),
          );
        }
      }

      // 5. Enviamos el paquete
      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 10),
      );
      var response = await http.Response.fromStream(streamedResponse);

      // 6. Si el servidor responde bien (201 Created o 200 OK)
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
