// lib/models/plant_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'plant_model.g.dart';

@JsonSerializable()
class PlantModel {
  final int? id;
  final String name;
  final String? scientificName;
  final String category;
  final String? description;
  final double? latitude;
  final double? longitude;

  // NUEVO: Agregamos el campo para la foto
  final String? fotografiaUrl;

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
    this.fotografiaUrl, // Añadido al constructor
    required this.tecnicoId,
  });

  factory PlantModel.fromJson(Map<String, dynamic> json) =>
      _$PlantModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlantModelToJson(this);
}
