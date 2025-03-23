import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF64FFDA);
  static const Color accent = Color(0xFFFF9E80);
  
  // Background colors
  static const Color background = Color(0xFF0A1828);
  static const Color surfaceDark = Color(0xFF0F2136);
  static const Color surfaceLight = Color(0xFF152A45);

  // Text colors
  static const Color textLight = Colors.white;
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textMuted = Color(0xFF8892B0);

  // Utility colors
  static const Color dividerDark = Color(0xFF2D3A51);
  static const Color dividerLight = Color(0xFFE0E0E0);
  
  // Card and container gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF64FFDA), Color(0xFF48A999)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF0F2136), Color(0xFF1A3A5F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

