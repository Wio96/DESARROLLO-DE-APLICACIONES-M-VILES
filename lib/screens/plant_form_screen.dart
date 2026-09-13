import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database/database.dart';
import '../config/api_constants.dart';
import 'login_screen.dart';
import 'plants_screen.dart';

class PlantFormScreen extends StatefulWidget {
  final String userId;
  final AppDatabase database;

  const PlantFormScreen({
    super.key,
    required this.userId,
    required this.database,
  });

  @override
  State<PlantFormScreen> createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _scientificNameController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Medicinal';
  final List<String> _categories = [
    'Medicinal',
    'Maderable',
    'Frutal',
    'Ornamental',
    'Cultural',
  ];

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isSaving = false;

  // VARIABLE DE ESTADO DE CONEXIÓN PARA EL INDICADOR VISUAL
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _verificarConexionInicial();
  }

  // Verificamos el estado al abrir la pantalla
  Future<void> _verificarConexionInicial() async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConstants.baseUrl}/plants'))
          .timeout(const Duration(seconds: 3));
      if (mounted) {
        setState(() {
          _isOnline = response.statusCode < 500;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isOnline = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    await _storage.deleteAll();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _savePlant() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final plantData = {
      'name': _nameController.text.trim(),
      'scientificName': _scientificNameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'category': _selectedCategory,
      'latitude': -1.5000,
      'longitude': -77.9000,
      'userId': widget.userId,
    };

    bool conexionExitosa = false;
    int? idRetornado;

    try {
      final response = await http
          .post(
            Uri.parse('${ApiConstants.baseUrl}/plants'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(plantData),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        conexionExitosa = true;
        final responseData = jsonDecode(response.body);
        idRetornado = int.tryParse(responseData['plant']['id'].toString());
      }
    } catch (e) {
      print('🚨 SEÑAL PERDIDA O FALLO DE RED: $e');
    }

    // Actualizamos el estado visual de la app según el resultado
    setState(() {
      _isOnline = conexionExitosa;
    });

    try {
      if (conexionExitosa) {
        if (_imageFile != null && idRetornado != null) {
          await _uploadPhoto(idRetornado);
        }

        await widget.database
            .into(widget.database.registrosCampo)
            .insert(
              RegistrosCampoCompanion(
                id: drift.Value(
                  DateTime.now().millisecondsSinceEpoch.toString(),
                ),
                nombreEspecie: drift.Value(_nameController.text.trim()),
                latitud: const drift.Value(-1.5000),
                longitud: const drift.Value(-77.9000),
                fotografiaUrl: drift.Value(_imageFile?.path ?? ''),
                sincronizado: const drift.Value(true),
              ),
            );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Planta sincronizada con éxito en MariaDB! 🌿'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        await widget.database
            .into(widget.database.registrosCampo)
            .insert(
              RegistrosCampoCompanion(
                id: drift.Value(
                  DateTime.now().millisecondsSinceEpoch.toString(),
                ),
                nombreEspecie: drift.Value(_nameController.text.trim()),
                latitud: const drift.Value(-1.5000),
                longitud: const drift.Value(-77.9000),
                fotografiaUrl: drift.Value(_imageFile?.path ?? ''),
                sincronizado: const drift.Value(false),
              ),
            );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Sin conexión: Guardado local para sincronizar luego 📱',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }

      _formKey.currentState?.reset();
      setState(() {
        _imageFile = null;
      });
    } catch (errorInterno) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error de validación local: $errorInterno'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _uploadPhoto(int plantId) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}/plants/photo'),
    );
    request.fields['plantId'] = plantId.toString();
    if (_imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath('photo', _imageFile!.path),
      );
    }

    var streamedResponse = await request.send();
    await http.Response.fromStream(streamedResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Planta - Biosacha'),
        backgroundColor: const Color(0xFF1B4D3E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'Ver Listado',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantsScreen(database: widget.database),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          // INDICADOR VISUAL DE ESTADO (ONLINE / OFFLINE)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: _isOnline ? Colors.green.shade100 : Colors.orange.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isOnline ? Icons.wifi : Icons.wifi_off,
                  color: _isOnline
                      ? Colors.green.shade800
                      : Colors.orange.shade800,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _isOnline
                      ? 'Modo En Línea (Conectado al Servidor)'
                      : 'Modo Offline (Sin conexión - Datos Locales)',
                  style: TextStyle(
                    color: _isOnline
                        ? Colors.green.shade900
                        : Colors.orange.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre común de la planta *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 3) {
                          return 'El nombre debe tener al menos 3 letras';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _scientificNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre científico',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Categoría',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories
                          .map(
                            (cat) =>
                                DropdownMenuItem(value: cat, child: Text(cat)),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedCategory = val!),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Descripción / Usos tradicionales',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Tomar Foto'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Galería'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (_imageFile != null)
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      const Text(
                        'Ninguna foto seleccionada',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _isSaving ? null : _savePlant,
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Guardar Registro',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
