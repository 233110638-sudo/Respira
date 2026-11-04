import 'package:flutter/material.dart';

class AppColors {
  static const Color primario = Color(0xFF587A68);
  static const Color primarioClaro = Color(0xFFE4EEE7);
  static const Color textoPrincipal = Color(0xFF26372F);
  static const Color textoSecundario = Color(0xFF69776E);
  static const Color fondo = Color(0xFFF7F8F5);
  static const Color alerta = Color(0xFFB65353);
}

ThemeData buildRespiraTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.fondo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primario,
      primary: AppColors.primario,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.fondo,
      foregroundColor: AppColors.textoPrincipal,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 27,
        height: 1.2,
        fontWeight: FontWeight.w700,
        color: AppColors.textoPrincipal,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        height: 1.5,
        color: AppColors.textoPrincipal,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        height: 1.45,
        color: AppColors.textoSecundario,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        height: 1.4,
        color: AppColors.textoSecundario,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primario,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primario,
        side: const BorderSide(color: AppColors.primario),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
