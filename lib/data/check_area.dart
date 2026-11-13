import 'package:flutter/material.dart';

/// Áreas de la vida diaria que revisa el chequeo de bienestar.
/// Se usan solo para elegir sugerencias; nunca para dar un diagnóstico.
enum CheckArea {
  interes(Icons.palette_rounded),
  animo(Icons.wb_cloudy_rounded),
  descanso(Icons.bedtime_rounded),
  energia(Icons.battery_charging_full_rounded),
  alimentacion(Icons.restaurant_rounded),
  autoestima(Icons.favorite_rounded),
  concentracion(Icons.center_focus_strong_rounded),
  conexion(Icons.groups_rounded),
  seguridad(Icons.health_and_safety_rounded);

  const CheckArea(this.icon);

  final IconData icon;
}
