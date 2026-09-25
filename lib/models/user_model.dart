// lib/models/user_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;

  // DIVERGENCIA DOCUMENTADA:
  // En la base de datos se llama 'nombre', pero en nuestro modelo Dart usamos 'name'
  @JsonKey(name: 'nombre')
  final String name;

  final String rol;

  UserModel({required this.id, required this.name, required this.rol});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
