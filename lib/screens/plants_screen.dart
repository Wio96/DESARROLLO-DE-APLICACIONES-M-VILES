import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../theme/app_tokens.dart';
import '../components/plant_card.dart';
import '../components/resource_state_handler.dart';
import '../components/custom_button.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({Key? key}) : super(key: key);

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  bool _isEmpty = false;
  String _errorMessage = '';
  List<dynamic> _plants = [];

  @override
  void initState() {
    super.initState();
    _fetchPlants();
  }

  Future<void> _fetchPlants() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/plants'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _plants = data;
          _isEmpty = _plants.isEmpty;
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _errorMessage = 'Error del servidor: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Fallo de red. Verifique su servidor backend.';
        _isLoading = false;
      });
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingMd),
        child: Column(
          children: [
            Expanded(
              child: ResourceStateHandler(
                isLoading: _isLoading,
                hasError: _hasError,
                errorMessage: _errorMessage,
                isEmpty: _isEmpty,
                onRetry: _fetchPlants,
                child: ListView.builder(
                  itemCount: _plants.length,
                  itemBuilder: (context, index) {
                    final plant = _plants[index];
                    return PlantCard(
                      name: plant['name'] ?? 'Sin nombre',
                      scientificName: plant['scientificName'],
                      category: plant['category'] ?? 'General',
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacingMd),
            CustomButton(
              label: 'Actualizar Lista',
              onPressed: _fetchPlants,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
