// lib/repositories/plant_repository.dart
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as drift;
import '../config/api.client.dart';
import '../database/database.dart';
import '../models/plant_model.dart';
import '../exceptions/app_exceptions.dart';

class PlantRepository {
  final ApiClient _apiClient = ApiClient();
  final AppDatabase _database;

  PlantRepository(this._database);

  // La pantalla llamará a esta función y no sabrá si hay internet o no
  Future<String> savePlant(PlantModel plant, String? imagePath) async {
    try {
      // 1. FUENTE REMOTA: Intentamos enviar a MariaDB usando Dio
      final response = await _apiClient.dio.post(
        '/plants',
        data: plant.toJson(),
      );

      if (response.statusCode == 201) {
        final int newId = response.data['plant']['id'];

        // 2. Si hay foto y hay internet, la subimos directamente (Lógica que tenías en tu pantalla)
        if (imagePath != null) {
          final formData = FormData.fromMap({
            'plantId': newId.toString(),
            'photo': await MultipartFile.fromFile(imagePath),
          });
          await _apiClient.dio.post('/plants/photo', data: formData);
        }

        // 3. FUENTE LOCAL: Guardamos en Drift como "sincronizado" (true)
        await _saveToLocal(plant, imagePath, newId.toString(), true);
        return "¡Planta sincronizada con éxito en MariaDB! 🌿";
      }
      return "Guardado exitosamente.";
    } on DioException catch (e) {
      // Traducimos el error feo a un mensaje legible
      final mensajeDominio = AppExceptions.getErrorMessage(e);

      // Si el error es por falta de internet, guardamos offline
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        final tempId = DateTime.now().millisecondsSinceEpoch.toString();
        // FUENTE LOCAL: Guardamos en Drift como "Pendiente" (false)
        await _saveToLocal(plant, imagePath, tempId, false);
        return "Sin conexión: Guardado local para sincronizar luego 📱";
      }

      // Si es un error del servidor (ej. 422 o 500), se lo lanzamos a la pantalla
      throw Exception(mensajeDominio);
    }
  }

  // Método privado para insertar en Drift
  Future<void> _saveToLocal(
    PlantModel plant,
    String? imagePath,
    String id,
    bool isSync,
  ) async {
    await _database
        .into(_database.registrosCampo)
        .insert(
          RegistrosCampoCompanion(
            id: drift.Value(id),
            nombreEspecie: drift.Value(plant.name),
            latitud: drift.Value(plant.latitude ?? -1.5000),
            longitud: drift.Value(plant.longitude ?? -77.9000),
            fotografiaUrl: drift.Value(imagePath ?? ''),
            sincronizado: drift.Value(isSync),
          ),
        );
  }
}
