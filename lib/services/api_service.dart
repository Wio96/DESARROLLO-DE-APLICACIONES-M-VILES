import 'dart:convert';
// Nota: Cuando estés listo para conectar al servidor, descomenta la siguiente línea:
// import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api.biosacha.com/api/v1";

  // --- 4. DISEÑO DE ENDPOINTS Y CRUD ---

  // POST /api/v1/registros (Crear)
  Future<void> crearRegistro(Map<String, dynamic> data) async {
    // 6. VALIDACIÓN Y REGLAS DE NEGOCIO
    // Antes de procesar nada, validamos la integridad del hardware
    validarIntegridadHardware(data['latitud'], data['longitud']);

    print("Datos validados. Enviando POST a $baseUrl/registros...");
    // Lógica futura: http.post(Uri.parse('$baseUrl/registros'), body: jsonEncode(data));
  }

  // GET /api/v1/registros?pagina=1&limite=20 (Listar con Paginación)
  Future<void> listarRegistros({int pagina = 1, int limite = 20}) async {
    print("Obteniendo registros de la página $pagina con límite $limite");
    // Lógica futura: http.get(Uri.parse('$baseUrl/registros?pagina=$pagina&limite=$limite'));
  }

  // PATCH /api/v1/registros/{id} (Actualización Parcial)
  Future<void> actualizarEstado(int id, Map<String, dynamic> data) async {
    // 6. SEGURIDAD: Aquí se incluiría el token JWT en los headers
    print("Enviando PATCH a $baseUrl/registros/$id con validación JWT...");
  }

  // DELETE /api/v1/registros/{id} (Eliminación Lógica)
  Future<void> eliminarRegistro(int id) async {
    // Eliminación lógica (solo cambia un estado, no borra el registro físicamente)
    print("Ejecutando eliminación lógica en $baseUrl/registros/$id");
  }

  // --- 6. REGLAS DE NEGOCIO (Integridad de Hardware) ---

  void validarIntegridadHardware(dynamic lat, dynamic lon) {
    // Convertimos a double para asegurar la validación numérica
    final double latD = (lat as num).toDouble();
    final double lonD = (lon as num).toDouble();

    // Regla: Las coordenadas deben estar en rangos lógicos globales
    if (latD < -90 || latD > 90 || lonD < -180 || lonD > 180) {
      throw Exception(
        "Error 422: Coordenadas fuera de rango. El hardware no devolvió una posición GPS válida.",
      );
    }
  }
}
