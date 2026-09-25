// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantModel _$PlantModelFromJson(Map<String, dynamic> json) => PlantModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  scientificName: json['scientificName'] as String?,
  category: json['category'] as String,
  description: json['description'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  tecnicoId: json['userId'] as String,
);

Map<String, dynamic> _$PlantModelToJson(PlantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'scientificName': instance.scientificName,
      'category': instance.category,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'userId': instance.tecnicoId,
    };
