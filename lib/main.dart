import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'database/database.dart';

import 'screens/plant_form_screen.dart';
import 'screens/plants_screen.dart';
import 'screens/login_screen.dart';

late AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDatabase();

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
      home: const PantallaArranque(),
    );
  }
}

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

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    if (token != null) {
      // TODOS los usuarios con sesión activa van a la lista de plantas.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlantsScreen(database: database),
        ),
      );
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
