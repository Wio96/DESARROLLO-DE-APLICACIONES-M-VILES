// lib/screens/plant_form_screen.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database/database.dart';
import '../config/api.client.dart';
import '../models/plant_model.dart';
import '../repositories/plant_repository.dart';
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
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _verificarConexionInicial();
  }

  // Verificamos usando la instancia única de Dio
  Future<void> _verificarConexionInicial() async {
    try {
      final response = await ApiClient().dio.get('/plants');
      if (mounted) {
        setState(() {
          _isOnline = response.statusCode != null && response.statusCode! < 500;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isOnline = false);
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

    setState(() => _isSaving = true);

    // 1. Usamos el PlantModel con serialización generada
    final plantModel = PlantModel(
      name: _nameController.text.trim(),
      scientificName: _scientificNameController.text.trim().isEmpty
          ? null
          : _scientificNameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      category: _selectedCategory,
      latitude: -1.5000,
      longitude: -77.9000,
      tecnicoId: widget.userId,
    );

    try {
      // 2. Llamamos al cerebro (Repositorio). La pantalla ya no hace peticiones HTTP.
      final repository = PlantRepository(widget.database);
      final mensaje = await repository.savePlant(plantModel, _imageFile?.path);

      // Actualizamos estado de conexión según la respuesta
      setState(() {
        _isOnline = !mensaje.contains('Sin conexión');
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: _isOnline ? Colors.green : Colors.orange,
        ),
      );

      // Limpiamos el formulario
      _formKey.currentState?.reset();
      setState(() => _imageFile = null);
    } catch (error) {
      if (!mounted) return;
      // Mostramos los errores de validación (422) o del servidor en rojo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceAll('Exception:', '').trim()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
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
