class RegistroDTO {
  final int id;
  final double latitud;
  final double longitud;

  RegistroDTO({
    required this.id,
    required this.latitud,
    required this.longitud,
  });

  // Esto convierte tu objeto a JSON para cumplir con el contrato de la API
  Map<String, dynamic> toJson() => {
    "id_registro": id,
    "latitud": latitud,
    "longitud": longitud,
  };
}
