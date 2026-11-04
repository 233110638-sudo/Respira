import 'package:flutter/material.dart';

import '../core_theme.dart';
import '../widgets/action_card.dart';
import '../widgets/section_label.dart';
import 'articles_screen.dart';
import 'breathing_screen.dart';
import 'crisis_screen.dart';
import 'grounding_screen.dart';
import 'home_screen.dart';

enum WellbeingResultType {
  calmAndPsychologist, // 10-21 puntos: Ejercicios de calma y psicólogo destacado
  wellnessAndArticles, // 0-9 puntos: Ejercicios de bienestar y artículos
}

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({
    required this.resultType,
    super.key,
  });

  final WellbeingResultType resultType;

  @override
  Widget build(BuildContext context) {
    final isCalmFocus = resultType == WellbeingResultType.calmAndPsychologist;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recomendaciones'),
        actions: [
          IconButton(
            tooltip: 'Necesito ayuda ahora',
            icon: const Icon(Icons.support_rounded, color: AppColors.alerta),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CrisisScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
              children: [
                // Encabezado empático (sin puntajes ni etiquetas clínicas)
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isCalmFocus
                          ? [const Color(0xFFF6EFE9), const Color(0xFFF9F5F1)]
                          : [const Color(0xFFE4EEE7), const Color(0xFFF0F5F1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isCalmFocus
                                  ? const Color(0xFFE8D7CA)
                                  : AppColors.primarioClaro,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              isCalmFocus
                                  ? Icons.favorite_rounded
                                  : Icons.spa_rounded,
                              color: isCalmFocus
                                  ? const Color(0xFF8C5836)
                                  : AppColors.primario,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              isCalmFocus
                                  ? 'Cuidar de ti es prioritario'
                                  : 'Espacios para tu bienestar',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isCalmFocus
                          ? 'Has estado experimentando una sobrecarga notable en los últimos días. Recuerda que no tienes que resolver todo de inmediato; dar pequeños pasos y contar con apoyo hace la diferencia.'
                          : 'Dedicar unos minutos a revisar cómo te sientes es un gran hábito. Te sugerimos actividades y lecturas para mantener tu equilibrio y tranquilidad.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textoPrincipal,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 10-21 PUNTOS: Psicólogo destacado prioritario
                if (isCalmFocus) ...[
                  const SectionLabel('Acompañamiento profesional'),
                  const SizedBox(height: 10),
                  _PsychologistHighlightCard(
                    isHighlighted: true,
                    title: 'Te recomendamos acudir con un psicólogo',
                    description:
                        'Hablar con un profesional de la psicología te brindará un espacio seguro y confidencial, con herramientas personalizadas para transitar lo que estás viviendo.',
                  ),
                  const SizedBox(height: 24),
                ],

                // Sección de Ejercicios
                SectionLabel(
                  isCalmFocus ? 'Ejercicios de calma sugeridos' : 'Ejercicios de bienestar',
                ),
                const SizedBox(height: 10),

                // Ejercicio de Respiración
                ActionCard(
                  icon: Icons.air_rounded,
                  title: 'Ejercicio de respiración',
                  description: 'Un ciclo suave guiado para desacelerar y soltar la tensión física.',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BreathingScreen()),
                  ),
                ),
                const SizedBox(height: 12),

                // Ejercicio de Grounding
                ActionCard(
                  icon: Icons.filter_center_focus_rounded,
                  title: 'Ejercicio de conexión (Grounding 5-4-3-2-1)',
                  description: 'Regresa al momento presente utilizando tus cinco sentidos.',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GroundingScreen()),
                  ),
                ),
                const SizedBox(height: 24),

                // Sección de Artículos
                const SectionLabel('Lecturas psicoeducativas'),
                const SizedBox(height: 10),
                ActionCard(
                  icon: Icons.article_outlined,
                  title: 'Artículos de nuestra psicóloga',
                  description: 'Aprende a comprender las respuestas de tu mente y cuerpo.',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ArticlesScreen()),
                  ),
                ),
                const SizedBox(height: 24),

                // 0-9 PUNTOS: Recomendación general de acudir con un psicólogo
                if (!isCalmFocus) ...[
                  const SectionLabel('Orientación profesional'),
                  const SizedBox(height: 10),
                  _PsychologistHighlightCard(
                    isHighlighted: false,
                    title: 'La consulta psicológica como prevención',
                    description:
                        'Siempre es recomendable acudir con un psicólogo, incluso en etapas tranquilas. Es un recurso clave para fortalecer tu bienestar y autoconocimiento.',
                  ),
                  const SizedBox(height: 24),
                ],

                // Botón destacado a Crisis
                Material(
                  color: const Color(0xFFFFF1EF),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CrisisScreen()),
                    ),
                    borderRadius: BorderRadius.circular(18),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9DEDA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.support_rounded, color: AppColors.alerta),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '¿Necesitas ayuda inmediata?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF7A2E2E),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Consulta números gratuitos de emergencia y apoyo en crisis 24 horas.',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Color(0xFF6E4A47),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.alerta),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Botón para ir al Inicio
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    ),
                    child: const Text('Ir a la pantalla de inicio'),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Respira ofrece orientación general y ejercicios; no sustituye la evaluación de profesionales de la salud.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PsychologistHighlightCard extends StatelessWidget {
  const _PsychologistHighlightCard({
    required this.isHighlighted,
    required this.title,
    required this.description,
  });

  final bool isHighlighted;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFFFFF9F0) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted ? const Color(0xFFE5B378) : const Color(0xFFE8ECE8),
          width: isHighlighted ? 1.6 : 1,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: const Color(0xFFC78B43).withValues(alpha: 0.1),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isHighlighted ? const Color(0xFFF9E8D2) : AppColors.primarioClaro,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.psychology_rounded,
              color: isHighlighted ? const Color(0xFF99611D) : AppColors.primario,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isHighlighted ? const Color(0xFF6E4009) : AppColors.textoPrincipal,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.45,
                    color: isHighlighted ? const Color(0xFF5A3911) : AppColors.textoSecundario,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
