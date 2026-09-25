// lib/models/plant_model.dart
import 'package:json_annotation/json_annotation.dart';

// Esta línea marcará un error en rojo al principio. Es normal, el archivo .g.dart se generará luego.
part 'plant_model.g.dart';

@JsonSerializable()
class PlantModel {
  // Anulable: Cuando creamos la planta offline, aún no tiene ID de la base de datos
  final int? id;

  final String name;

  // Campos opcionales declarados como anulables (?) según requerimiento
  final String? scientificName;
  final String category;
  final String? description;
  final double? latitude;
  final double? longitude;

  // DIVERGENCIA DOCUMENTADA:
  // El backend Node.js envía este campo como 'userId', pero en el cliente
  // móvil lo mapeamos semánticamente como 'tecnicoId'.
  @JsonKey(name: 'userId')
  final String tecnicoId;

  PlantModel({
    this.id,
    required this.name,
    this.scientificName,
    required this.category,
    this.description,
    this.latitude,
    this.longitude,
    required this.tecnicoId,
  });

  // Métodos mágicos que conectan con el código autogenerado
  factory PlantModel.fromJson(Map<String, dynamic> json) =>
      _$PlantModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlantModelToJson(this);
}
