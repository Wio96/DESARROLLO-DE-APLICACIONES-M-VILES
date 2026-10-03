// lib/screens/plant_form_screen.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart'; // NUEVO: Importamos el GPS
import '../database/database.dart';
import '../config/api.client.dart';
import '../models/plant_model.dart';
import '../repositories/plant_repository.dart';

class PlantFormScreen extends StatefulWidget {
  final String userId;
  final AppDatabase database;
  final PlantModel? plantToEdit;

  const PlantFormScreen({
    super.key,
    required this.userId,
    required this.database,
    this.plantToEdit,
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

  // NUEVO: Variables para el GPS
  double? _currentLatitude;
  double? _currentLongitude;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _verificarConexionInicial();

    if (widget.plantToEdit != null) {
      // Si estamos editando, usamos las coordenadas y datos que ya existen
      _nameController.text = widget.plantToEdit!.name;
      _scientificNameController.text = widget.plantToEdit!.scientificName ?? '';
      _descriptionController.text = widget.plantToEdit!.description ?? '';
      if (_categories.contains(widget.plantToEdit!.category)) {
        _selectedCategory = widget.plantToEdit!.category;
      }
      _currentLatitude = widget.plantToEdit!.latitude;
      _currentLongitude = widget.plantToEdit!.longitude;
      _isLoadingLocation = false;
    } else {
      // Si es un registro nuevo, encendemos el GPS
      _obtenerUbicacion();
    }
  }

  // NUEVO: Lógica maestra para capturar el GPS real
  Future<void> _obtenerUbicacion() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Revisa si el GPS del celular está encendido
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) setState(() => _isLoadingLocation = false);
      return;
    }

    // 2. Revisa si el usuario nos dio permiso
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) setState(() => _isLoadingLocation = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) setState(() => _isLoadingLocation = false);
      return;
    }

    // 3. ¡Capturamos la latitud y longitud exacta!
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    if (mounted) {
      setState(() {
        _currentLatitude = position.latitude;
        _currentLongitude = position.longitude;
        _isLoadingLocation = false;
      });
    }
  }

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
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
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

    final plantModel = PlantModel(
      id: widget.plantToEdit?.id,
      name: _nameController.text.trim(),
      scientificName: _scientificNameController.text.trim().isEmpty
          ? null
          : _scientificNameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      category: _selectedCategory,
      // NUEVO: Guardamos el GPS real. Si falla, usa coordenadas base de Pastaza.
      latitude: _currentLatitude ?? -1.5000,
      longitude: _currentLongitude ?? -77.9000,
      tecnicoId: widget.userId,
    );

    try {
      final repository = PlantRepository(widget.database);
      final mensaje = await repository.savePlant(plantModel, _imageFile?.path);

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

      _formKey.currentState?.reset();
      setState(() => _imageFile = null);

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
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
        title: Text(
          widget.plantToEdit != null ? 'Editar Planta' : 'Registrar Planta',
        ),
        backgroundColor: const Color(0xFF1B4D3E),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver al Listado',
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
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
                  _isOnline ? 'En Línea' : 'Offline (Datos Locales)',
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
                      value: _selectedCategory,
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
                    const SizedBox(height: 16),

                    // NUEVO: Indicador visual del estado del GPS
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _isLoadingLocation
                                  ? 'Obteniendo GPS...'
                                  : (_currentLatitude != null
                                        ? 'Ubicación lista: ${_currentLatitude!.toStringAsFixed(4)}, ${_currentLongitude!.toStringAsFixed(4)}'
                                        : 'No se pudo obtener el GPS. Se usará la ubicación base.'),
                              style: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
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
                          : Text(
                              widget.plantToEdit != null
                                  ? 'Actualizar Registro'
                                  : 'Guardar Registro',
                              style: const TextStyle(fontSize: 16),
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
