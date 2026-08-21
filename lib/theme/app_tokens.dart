import 'package:flutter/material.dart';

class AppTokens {
  // Nivel 1: Tokens Primitivos (Colores y medidas puras)
  static const Color primaryTurquoise500 = Color(0xFF00ABA8);
  static const Color primaryNavy900 = Color(0xFF0A192F);
  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color neutralGrey100 = Color(0xFFF4F6F8);
  static const Color neutralGrey600 = Color(0xFF657786);
  static const Color errorRed = Color(0xFFD32F2F);

  // Nivel 2: Tokens Semánticos (Significado en el sistema)
  static const Color colorBackground = neutralGrey100;
  static const Color colorSurface = neutralWhite;
  static const Color colorTextPrimary = primaryNavy900;
  static const Color colorTextSecondary = neutralGrey600;
  static const Color colorActionPrimary = primaryTurquoise500;
  static const Color colorFeedbackError = errorRed;

  // Espaciados y Radios (Para cumplir el área táctil mínima de 44-48pt)
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double radiusCircular = 12.0;
}
