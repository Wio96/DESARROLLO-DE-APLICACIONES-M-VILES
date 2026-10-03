// lib/screens/users_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_constants.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _storage = const FlutterSecureStorage();
  List<dynamic> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await _storage.read(key: 'jwt_token');

      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/auth/users'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _users = data is List ? data : (data['users'] ?? data['data'] ?? []);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error al cargar usuarios: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'No se pudo conectar con el servidor.';
        _isLoading = false;
      });
    }
  }

  // NUEVO: Función para enviar el nuevo rol al servidor
  Future<void> _updateRole(String userId, String newRole) async {
    setState(() => _isLoading = true);
    try {
      final token = await _storage.read(key: 'jwt_token');

      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}/auth/users/$userId/role'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'rol': newRole}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rol actualizado con éxito'),
            backgroundColor: Colors.green,
          ),
        );
        _fetchUsers(); // Recargamos la lista
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al actualizar rol'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isLoading = false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error de conexión'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  // NUEVO: Menú emergente para seleccionar el rol
  Future<void> _showRoleDialog(Map<String, dynamic> user) async {
    String selectedRole = (user['rol'] ?? 'visitante').toString().toLowerCase();
    final List<String> roles = ['visitante', 'tecnico', 'admin'];

    // Para evitar errores si el rol de la BD tiene espacios o mayúsculas raras
    if (!roles.contains(selectedRole)) selectedRole = 'visitante';

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Modificar rol de ${user['nombre'] ?? 'Usuario'}'),
              content: DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: roles
                    .map(
                      (r) => DropdownMenuItem(
                        value: r,
                        child: Text(r.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setStateDialog(() => selectedRole = val!);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4D3E),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Cerramos el modal
                    _updateRole(
                      user['id'].toString(),
                      selectedRole,
                    ); // Ejecutamos el cambio
                  },
                  child: const Text('Guardar Cambio'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        backgroundColor: const Color(0xFF1B4D3E),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          : _users.isEmpty
          ? const Center(child: Text('No hay usuarios registrados.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF2E7D32),
                      child: Text(
                        user['nombre']?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      user['nombre'] ?? user['name'] ?? 'Sin nombre',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user['email'] ?? 'Sin correo'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Chip(
                          label: Text(
                            (user['rol'] ?? 'visitante')
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.teal.shade100,
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showRoleDialog(user),
                          tooltip: 'Cambiar Rol',
                        ),
                      ],
                    ),
                    // También se puede abrir el diálogo tocando toda la tarjeta
                    onTap: () => _showRoleDialog(user),
                  ),
                );
              },
            ),
    );
  }
}
