import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biosacha Conectividad',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String statusText =
      "Haz clic en el botón para probar la conexión con el Backend";

  Future<void> testConnection() async {
    setState(() {
      statusText = "Conectando con el servidor...";
    });

    try {
      // Como corremos en Chrome, usamos localhost directamente
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/plants'),
      );

      if (response.statusCode == 200) {
        setState(() {
          statusText =
              "¡Conexión Exitosa!\n\nRespuesta del Backend:\n${response.body}";
        });
      } else {
        setState(() {
          statusText =
              "El servidor respondió con error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        statusText =
            "Error de red: No se pudo alcanzar el backend.\n¿Está encendido Node.js?\n\nDetalle: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biosacha - Taller Semana 9'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_sync, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                statusText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: testConnection,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'Probar Petición a la API',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
