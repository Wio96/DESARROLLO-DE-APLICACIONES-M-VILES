import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../theme/app_tokens.dart';
import '../components/plant_card.dart';
import '../components/resource_state_handler.dart';
import '../components/custom_button.dart';
import '../database/database.dart';
import '../services/sync_service.dart';
import '../config/api_constants.dart';

class PlantsScreen extends StatefulWidget {
  final AppDatabase database;

  const PlantsScreen({super.key, required this.database});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  bool _isSyncing = false;
  final _secureStorage = const FlutterSecureStorage();

  Future<void> _cerrarSesion() async {
    await _secureStorage.delete(key: 'jwt_token');
    await _secureStorage.delete(key: 'user_role');

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
            content: Text('¡$cantidad plantas sincronizadas con éxito! 🌿'),
            backgroundColor: Colors.green,
          ),
        );
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
          content: Text('No se pudo conectar al servidor. Revisa tu conexión.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTokens.colorBackground,
      appBar: AppBar(
        title: const Text('Catálogo Biosacha'),
        backgroundColor: AppTokens.colorActionPrimary,
        foregroundColor: AppTokens.neutralWhite,
        actions: [
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
            Expanded(
              child: StreamBuilder<List<RegistrosCampoData>>(
                stream: widget.database
                    .select(widget.database.registrosCampo)
                    .watch(),
                builder: (context, snapshot) {
                  final bool isLoading =
                      snapshot.connectionState == ConnectionState.waiting;
                  final bool hasError = snapshot.hasError;
                  final bool isEmpty =
                      !isLoading &&
                      !hasError &&
                      (!snapshot.hasData || snapshot.data!.isEmpty);

                  return ResourceStateHandler(
                    isLoading: isLoading,
                    hasError: hasError,
                    errorMessage: 'Error al leer el almacenamiento local',
                    isEmpty: isEmpty,
                    onRetry: () {},
                    child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final planta = snapshot.data![index];
                        return PlantCard(
                          name: planta.nombreEspecie,
                          scientificName: 'Registro en territorio',
                          category: planta.sincronizado
                              ? 'Sincronizado'
                              : 'Pendiente (Modo Avión)',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlantDetailScreen(planta: planta),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppTokens.spacingMd),
            CustomButton(
              label: 'Sincronizar Pendientes',
              onPressed: _sincronizarConServidor,
              isLoading: _isSyncing,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// PANTALLA DE DETALLES (Muestra info completa y botón regresar)
// =====================================================================
class PlantDetailScreen extends StatelessWidget {
  final RegistrosCampoData planta;

  const PlantDetailScreen({super.key, required this.planta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planta.nombreEspecie),
        backgroundColor: const Color(0xFF1B4D3E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.eco, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Nombre Común',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              planta.nombreEspecie,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4D3E),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Estado del Registro',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  planta.sincronizado ? Icons.cloud_done : Icons.cloud_off,
                  color: planta.sincronizado ? Colors.green : Colors.orange,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    planta.sincronizado
                        ? 'Enviado correctamente al servidor (MariaDB)'
                        : 'Guardado offline. Pendiente de sincronizar.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Información Científica y Usos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.science, color: Color(0xFF2E7D32)),
              title: Text('Nombre Científico'),
              subtitle: Text('Sincronizando desde la base de datos...'),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.category, color: Color(0xFF2E7D32)),
              title: Text('Categoría'),
              subtitle: Text('Sincronizando desde la base de datos...'),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.menu_book, color: Color(0xFF2E7D32)),
              title: Text('Descripción / Usos'),
              subtitle: Text('Sincronizando desde la base de datos...'),
            ),
          ],
        ),
      ),
    );
  }
}
