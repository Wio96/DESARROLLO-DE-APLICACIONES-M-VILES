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

  // POST: Crear Planta (Ya lo tenías)
  Future<String> savePlant(PlantModel plant, String? imagePath) async {
    try {
      final response = await _apiClient.dio.post(
        '/plants',
        data: plant.toJson(),
      );

      if (response.statusCode == 201) {
        final int newId = response.data['plant']['id'];

        if (imagePath != null) {
          final formData = FormData.fromMap({
            'plantId': newId.toString(),
            'photo': await MultipartFile.fromFile(imagePath),
          });
          await _apiClient.dio.post('/plants/photo', data: formData);
        }

        await _saveToLocal(plant, imagePath, newId.toString(), true);
        return "¡Planta sincronizada con éxito en MariaDB! 🌿";
      }
      return "Guardado exitosamente.";
    } on DioException catch (e) {
      final mensajeDominio = AppExceptions.getErrorMessage(e);

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        final tempId = DateTime.now().millisecondsSinceEpoch.toString();
        await _saveToLocal(plant, imagePath, tempId, false);
        return "Sin conexión: Guardado local para sincronizar luego 📱";
      }

      throw Exception(mensajeDominio);
    }
  }

  // GET: Obtener todas las plantas (Con optimización de filtro)
  Future<List<PlantModel>> getAllPlants({String? category}) async {
    try {
      final String url = category != null && category.isNotEmpty
          ? '/plants?category=$category'
          : '/plants';

      final response = await _apiClient.dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PlantModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw Exception(AppExceptions.getErrorMessage(e));
    }
  }

  // PUT: Actualizar Planta
  Future<void> updatePlant(int id, PlantModel plant) async {
    try {
      await _apiClient.dio.put('/plants/$id', data: plant.toJson());
    } on DioException catch (e) {
      throw Exception(AppExceptions.getErrorMessage(e));
    }
  }

  // DELETE: Eliminar Planta
  Future<void> deletePlant(int id) async {
    try {
      await _apiClient.dio.delete('/plants/$id');
    } on DioException catch (e) {
      throw Exception(AppExceptions.getErrorMessage(e));
    }
  }

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
