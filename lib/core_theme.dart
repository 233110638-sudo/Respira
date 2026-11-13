
import 'package:flutter/material.dart';

class AppColors {
  // Paleta de colores principal de Respira.
  // Colores organizados para mantener una interfaz uniforme
  // en las diferentes pantallas de la aplicación.
  static const Color primario = Color(0xFF2D6A64); // Verde pino oscuro / teal
  static const Color primarioOscuro = Color(0xFF245550);
  static const Color primarioClaro = Color(0xFFE6EFEA); // Mint suave para selecciones y tabs
  static const Color fondo = Color(0xFFF7F8F7); // Fondo limpio y suave
  static const Color fondoMenta = Color(0xFFEAF2EF); // Fondo para pantalla de respiración
  static const Color textoPrincipal = Color(0xFF1B2320); // Texto principal oscuro
  static const Color textoSecundario = Color(0xFF5A6660); // Texto secundario
  static const Color alerta = Color(0xFFA82721); // Rojo para botones de emergencia y crisis
  static const Color alertaFondo = Color(0xFFFDEEED); // Fondo rosa suave para avisos de riesgo
  static const Color borde = Color(0xFFE2E6E3); // Borde sutil de tarjetas
  static const Color calido = Color(0xFFE59A4C); // Acento cálido para ánimo y logros
  static const Color calidoFondo = Color(0xFFFFF3E6); // Fondo cálido suave
  static const Color psicologo = Color(0xFF3E5C8A); // Azul para la recomendación profesional
  static const Color psicologoFondo = Color(0xFFEAF0F8);

  // Colores para los niveles de ánimo (de muy bajo a muy bien).
  static const List<Color> animo = [
    Color(0xFF7C8AA5),
    Color(0xFF8FA3B8),
    Color(0xFFB7B38A),
    Color(0xFF7FB08F),
    Color(0xFF4F9A78),
  ];
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
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textoPrincipal,
      elevation: 0,
      centerTitle: false,
    ),
    fontFamily: null,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textoPrincipal,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.textoPrincipal,
        letterSpacing: -0.3,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textoPrincipal,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.45,
        color: AppColors.textoPrincipal,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.45,
        color: AppColors.textoSecundario,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 1.35,
        color: AppColors.textoSecundario,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primario,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primario,
        side: const BorderSide(color: AppColors.primario, width: 1.2),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
  );
}
