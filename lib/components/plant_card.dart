import 'package:flutter/material.dart';
import '../theme/app_tokens.dart';

class PlantCard extends StatelessWidget {
  final String name;
  final String? scientificName;
  final String category;
  final VoidCallback onTap;

  const PlantCard({
    Key? key,
    required this.name,
    this.scientificName,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const Icon(
                Icons.eco,
                color: AppTokens.colorActionPrimary,
                size: 32,
              ),
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
