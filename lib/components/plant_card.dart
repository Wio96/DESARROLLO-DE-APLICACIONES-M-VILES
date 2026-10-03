// lib/components/plant_card.dart
import 'package:flutter/material.dart';
import 'dart:io';
import '../theme/app_tokens.dart';

class PlantCard extends StatelessWidget {
  final String name;
  final String? scientificName;
  final String category;
  final String? imagePath; // NUEVO: Para recibir la foto
  final VoidCallback onTap;

  const PlantCard({
    Key? key,
    required this.name,
    this.scientificName,
    required this.category,
    this.imagePath, // NUEVO
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lógica para mostrar la miniatura o el ícono
    Widget thumbnail;
    if (imagePath != null &&
        imagePath!.isNotEmpty &&
        File(imagePath!).existsSync()) {
      thumbnail = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(imagePath!),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      );
    } else {
      thumbnail = Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppTokens.colorActionPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.eco,
          color: AppTokens.colorActionPrimary,
          size: 28,
        ),
      );
    }

    return Semantics(
      label: 'Planta: $name, categoría $category',
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTokens.radiusCircular),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: AppTokens.spacingSm),
          padding: const EdgeInsets.all(AppTokens.spacingMd),
          decoration: BoxDecoration(
            color: AppTokens.colorSurface,
            borderRadius: BorderRadius.circular(AppTokens.radiusCircular),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Aquí insertamos la foto miniatura
              thumbnail,
              const SizedBox(width: AppTokens.spacingMd),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTokens.colorTextPrimary,
                      ),
                    ),
                    if (scientificName != null &&
                        scientificName!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        scientificName!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: AppTokens.colorTextSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      'Categoría: $category',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTokens.colorActionPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppTokens.colorTextSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
