// lib/screens/plant_detail_screen.dart
import 'package:flutter/material.dart';
import 'dart:io';
import '../models/plant_model.dart';
import '../theme/app_tokens.dart';

class PlantDetailScreen extends StatelessWidget {
  final PlantModel plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    // Verificamos si existe una ruta de foto válida localmente
    final bool hasImage =
        plant.fotografiaUrl != null &&
        plant.fotografiaUrl!.isNotEmpty &&
        File(plant.fotografiaUrl!).existsSync();

    return Scaffold(
      backgroundColor: AppTokens.colorBackground,
      appBar: AppBar(
        title: Text(plant.name),
        backgroundColor: AppTokens.colorActionPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. LA FOTO EN GRANDE (Soporte dual: Internet y Local)
            if (plant.fotografiaUrl != null && plant.fotografiaUrl!.isNotEmpty)
              plant.fotografiaUrl!.startsWith('http')
                  ? Image.network(
                      plant.fotografiaUrl!,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      // Muestra un círculo de carga mientras descarga la foto de Render
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          height: 350,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      // Si falla la carga, muestra un icono de error
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 350,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : Image.file(
                      File(plant.fotografiaUrl!),
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
            else
              Container(
                height: 250,
                color: Colors.grey.shade300,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.park, size: 80, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Sin fotografía',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

            // 2. LOS DETALLES (El resto de tu código sigue igual...)

            // 2. LOS DETALLES
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTokens.colorTextPrimary,
                    ),
                  ),
                  if (plant.scientificName != null &&
                      plant.scientificName!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      plant.scientificName!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: AppTokens.colorTextSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),

                  // Etiqueta de Categoría
                  Chip(
                    label: Text(
                      plant.category,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: AppTokens.colorActionPrimary,
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Descripción',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    plant.description != null && plant.description!.isNotEmpty
                        ? plant.description!
                        : 'No hay descripción ni usos tradicionales registrados para esta planta.',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: AppTokens.colorTextPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
