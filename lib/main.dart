import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'database/database.dart';

// Importa tus pantallas reales
import 'screens/plant_form_screen.dart';
import 'screens/plants_screen.dart';
import 'screens/login_screen.dart'; // <-- Importación agregada para usar tu archivo correcto

// Instancia global de la base de datos Drift
late AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDatabase();

  // Precargar un registro inicial si la tabla está vacía
  final count = await database.select(database.registrosCampo).get();
  if (count.isEmpty) {
    await database
        .into(database.registrosCampo)
        .insert(
          RegistrosCampoCompanion.insert(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            nombreEspecie: 'Ilex guayusa (Guayusa)',
            latitud: -1.5000,
            longitud: -77.9000,
            fotografiaUrl: 'default_guayusa.png',
          ),
        );
  }

  runApp(const BiosachaApp());
}

class BiosachaApp extends StatelessWidget {
  const BiosachaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biosacha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F7F8),
      ),
      // Inicia evaluando el token de sesión almacenado
      home: const PantallaArranque(),
    );
  }
}

// ==========================================
// PANTALLA DE ARRANQUE (Verificación de Sesión)
// ==========================================
class PantallaArranque extends StatefulWidget {
  const PantallaArranque({super.key});

  @override
  State<PantallaArranque> createState() => _PantallaArranqueState();
}

class _PantallaArranqueState extends State<PantallaArranque> {
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _verificarSesion();
  }

  void _verificarSesion() async {
    String? token = await _storage.read(key: 'jwt_token');
    String? rolUsuario = await _storage.read(key: 'usuario_rol') ?? 'VISITANTE';
    String? idUsuario = await _storage.read(key: 'usuario_id') ?? '';

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    if (token != null) {
      // Si hay sesión activa, redirige según el rol guardado offline
      if (rolUsuario == 'TECNICO') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlantFormScreen(userId: idUsuario, database: database),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlantsScreen(database: database),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1B4D3E),
      body: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
