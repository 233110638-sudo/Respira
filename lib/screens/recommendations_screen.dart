import 'package:flutter/material.dart';

import '../core_theme.dart';
import '../data/check_area.dart';
import '../widgets/crisis_badge_button.dart';
import '../widgets/lifeline_card.dart';
import '../widgets/psychologist_card.dart';
import 'activation_screen.dart';
import 'articles_screen.dart';
import 'breathing_screen.dart';
import 'gratitude_screen.dart';
import 'home_screen.dart';

class _Suggestion {
  const _Suggestion({
    required this.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.builder,
  });

  final String key;
  final String title;
  final String description;
  final IconData icon;
  final WidgetBuilder builder;
}

/// Sugerencias después del chequeo.
/// Nunca muestra puntajes ni etiquetas: solo ideas de cuidado y,
/// siempre, la recomendación de acudir con un psicólogo.
class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({
    this.focusAreas = const [],
    this.safetyConcern = false,
    super.key,
  });

  final List<CheckArea> focusAreas;
  final bool safetyConcern;

  static final _pasos = _Suggestion(
    key: 'pasos',
    title: 'Pequeños pasos',
    description: 'Actividades de pocos minutos para mover el ánimo.',
    icon: Icons.directions_walk_rounded,
    builder: (_) => const ActivationScreen(),
  );

  static final _gratitud = _Suggestion(
    key: 'gratitud',
    title: 'Tres cosas buenas',
    description: 'Escribe tres momentos sencillos que valieron la pena.',
    icon: Icons.star_rounded,
    builder: (_) => const GratitudeScreen(),
  );

  static final _respiracion = _Suggestion(
    key: 'respiracion',
    title: 'Respiración 4-7-8',
    description: 'Una pausa breve para bajar el ritmo y enfocarte.',
    icon: Icons.air_rounded,
    builder: (_) => const BreathingScreen(),
  );

  static _Suggestion _articulo(String id, IconData icon) {
    final article = articleById(id);
    return _Suggestion(
      key: 'articulo_$id',
      title: article.title,
      description: article.subtitle,
      icon: icon,
      builder: (_) => ArticleDetailScreen(article: article),
    );
  }

  List<_Suggestion> _buildSuggestions() {
    final suggestions = <_Suggestion>[];

    void add(_Suggestion s) {
      if (!suggestions.any((item) => item.key == s.key)) suggestions.add(s);
    }

    for (final area in focusAreas) {
      switch (area) {
        case CheckArea.interes:
        case CheckArea.energia:
          add(_pasos);
          break;
        case CheckArea.animo:
          add(_gratitud);
          add(_pasos);
          break;
        case CheckArea.autoestima:
          add(_articulo('amabilidad', Icons.favorite_rounded));
          add(_gratitud);
          break;
        case CheckArea.descanso:
        case CheckArea.alimentacion:
          add(_articulo('rutina', Icons.bedtime_rounded));
          break;
        case CheckArea.concentracion:
          add(_respiracion);
          break;
        case CheckArea.conexion:
          add(_articulo('conexion', Icons.groups_rounded));
          break;
        case CheckArea.seguridad:
          break;
      }
    }

    // Sugerencias generales para completar la lista.
    add(_pasos);
    add(_gratitud);
    add(_respiracion);

    return suggestions.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = _buildSuggestions();

    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [CrisisBadgeButton()],
            ),
            const SizedBox(height: 22),
            // Encabezado en tarjeta
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primario, AppColors.primarioOscuro],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                children: [
                  Icon(Icons.spa_rounded, color: Colors.white, size: 36),
                  SizedBox(height: 12),
                  Text(
                    'Esto es para ti',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Gracias por tomarte este tiempo. Esto no es un diagnóstico: son ideas para cuidarte mientras buscas apoyo.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.5, height: 1.4, color: Color(0xFFE3EEEA)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            if (safetyConcern) ...[
              const LifelineCard(
                message:
                    'Lo que compartiste es importante. Llama ahora: te escuchan sin juzgarte.',
              ),
              const SizedBox(height: 14),
            ],
            // Recomendación obligatoria, sin importar las respuestas
            const PsychologistCard(),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.borde),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_rounded, color: AppColors.calido, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Ideas para empezar',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textoPrincipal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (final s in suggestions) ...[
                    _RecommendationCard(
                      suggestion: s,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: s.builder),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Ir al inicio',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primario,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.suggestion, required this.onTap});

  final _Suggestion suggestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.fondo,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primarioClaro,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(suggestion.icon, color: AppColors.primario),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion.title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textoPrincipal,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      suggestion.description,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: AppColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textoSecundario),
            ],
          ),
        ),
      ),
    );
  }
}
