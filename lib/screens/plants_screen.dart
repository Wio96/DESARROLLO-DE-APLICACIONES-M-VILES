// lib/screens/plants_screen.dart
import 'plant_detail_screen.dart'; // Importación de la pantalla de detalles
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../theme/app_tokens.dart';
import '../components/plant_card.dart';
import '../components/custom_button.dart';
import '../database/database.dart';
import '../services/sync_service.dart';
import '../repositories/plant_repository.dart';
import '../models/plant_model.dart';

// Limpiamos las importaciones duplicadas
import 'plant_form_screen.dart';
import 'users_screen.dart';

class PlantsScreen extends StatefulWidget {
  final AppDatabase database;

  const PlantsScreen({super.key, required this.database});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  bool _isSyncing = false;
  final _secureStorage = const FlutterSecureStorage();
  late PlantRepository _plantRepository;

  List<PlantModel> _plantsFromBackend = [];
  bool _isLoadingBackend = true;
  String? _errorMessage;

  String _userRole = 'visitante';
  String _userId = '';

  String _selectedCategory = 'Todas';
  final List<String> _categories = [
    'Todas',
    'Medicinal',
    'Maderable',
    'Frutal',
    'Ornamental',
    'Cultural',
  ];

  bool get _isAdmin => _userRole.contains('admin');
  bool get _isTecnico =>
      _userRole.contains('tecnico') || _userRole.contains('técnico');
  bool get _isVisitante => !_isAdmin && !_isTecnico;

  @override
  void initState() {
    super.initState();
    _plantRepository = PlantRepository(widget.database);
    _loadUserData();
    _loadPlantsFromBackend();
  }

  Future<void> _loadUserData() async {
    final role =
        await _secureStorage.read(key: 'user_role') ??
        await _secureStorage.read(key: 'usuario_rol');
    final id = await _secureStorage.read(key: 'userId');
    if (mounted) {
      setState(() {
        _userRole = role?.toLowerCase().trim() ?? 'visitante';
        _userId = id ?? '';
      });
    }
  }

  Future<void> _loadPlantsFromBackend({String? filterCategory}) async {
    setState(() {
      _isLoadingBackend = true;
      _errorMessage = null;
    });
    try {
      final plants = await _plantRepository.getAllPlants(
        category: (filterCategory != null && filterCategory != 'Todas')
            ? filterCategory
            : null,
      );
      setState(() {
        _plantsFromBackend = plants;
        _isLoadingBackend = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoadingBackend = false;
      });
    }
  }

  Future<void> _eliminarPlanta(int id) async {
    try {
      await _plantRepository.deletePlant(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Planta eliminada permanentemente 🗑️')),
      );
      _loadPlantsFromBackend(filterCategory: _selectedCategory);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al eliminar: $e')));
    }
  }

  Future<void> _cerrarSesion() async {
    await _secureStorage.deleteAll();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  Future<void> _sincronizarConServidor() async {
    setState(() => _isSyncing = true);
    try {
      final syncService = SyncService(widget.database);
      final cantidad = await syncService.procesarColaSalida();

      if (!mounted) return;

      if (cantidad > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡$cantidad plantas sincronizadas! 🌿'),
            backgroundColor: Colors.green,
          ),
        );
        _loadPlantsFromBackend(filterCategory: _selectedCategory);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hay registros pendientes.'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error de conexión.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTokens.colorBackground,
      appBar: AppBar(
        title: Text('Catálogo - ${_userRole.toUpperCase()}'),
        backgroundColor: AppTokens.colorActionPrimary,
        foregroundColor: AppTokens.neutralWhite,
        actions: [
          if (_isAdmin)
            IconButton(
              icon: const Icon(Icons.people),
              tooltip: 'Ver Usuarios',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UsersScreen()),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: _cerrarSesion,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingMd),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Filtrar por categoría',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.filter_list),
              ),
              items: _categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedCategory = val);
                  _loadPlantsFromBackend(filterCategory: val);
                }
              },
            ),
            const SizedBox(height: 10),

            Expanded(
              child: _isLoadingBackend
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                  ? const Center(
                      child: Text(
                        "Modo Offline activado.\nLas plantas se sincronizarán luego.",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _plantsFromBackend.length,
                      itemBuilder: (context, index) {
                        final planta = _plantsFromBackend[index];
                        return Column(
                          children: [
                            // INTEGRACIÓN: Tarjeta conectada con imagen y navegación
                            PlantCard(
                              name: planta.name,
                              scientificName:
                                  planta.scientificName ?? 'Desconocido',
                              category: planta.category,
                              imagePath: planta
                                  .fotografiaUrl, // Enviamos la foto a la tarjeta
                              onTap: () {
                                // Navegamos a la pantalla de detalles al tocar la tarjeta (o la flecha)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlantDetailScreen(plant: planta),
                                  ),
                                );
                              },
                            ),

                            if (!_isVisitante)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    label: const Text(
                                      'Editar',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlantFormScreen(
                                            userId: _userId,
                                            database: widget.database,
                                            plantToEdit: planta,
                                          ),
                                        ),
                                      ).then(
                                        (_) => _loadPlantsFromBackend(
                                          filterCategory: _selectedCategory,
                                        ),
                                      );
                                    },
                                  ),
                                  if (_isAdmin)
                                    TextButton.icon(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      label: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () =>
                                          _eliminarPlanta(planta.id!),
                                    ),
                                ],
                              ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
            ),
            const SizedBox(height: AppTokens.spacingMd),

            if (!_isVisitante)
              CustomButton(
                label: 'Sincronizar Pendientes',
                onPressed: _sincronizarConServidor,
                isLoading: _isSyncing,
              ),
          ],
        ),
      ),

      floatingActionButton: !_isVisitante
          ? FloatingActionButton(
              backgroundColor: AppTokens.colorActionPrimary,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantFormScreen(
                      userId: _userId,
                      database: widget.database,
                    ),
                  ),
                ).then(
                  (_) =>
                      _loadPlantsFromBackend(filterCategory: _selectedCategory),
                );
              },
            )
          : null,
    );
  }
}
