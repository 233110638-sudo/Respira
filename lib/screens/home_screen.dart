import 'package:flutter/material.dart';

import '../core_theme.dart';
import '../widgets/action_card.dart';
import '../widgets/section_label.dart';
import 'articles_screen.dart';
import 'breathing_screen.dart';
import 'crisis_screen.dart';
import 'grounding_screen.dart';
import 'support_someone_screen.dart';
import 'wellbeing_check_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 32),
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primarioClaro,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.spa_rounded,
                        color: AppColors.primario,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Text(
                      'respira',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Necesito ayuda ahora',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CrisisScreen()),
                      ),
                      icon: const Icon(Icons.support_rounded, color: AppColors.alerta),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE4EEE7), Color(0xFFF0F4EF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionLabel('Un momento para ti'),
                      const SizedBox(height: 10),
                      Text(
                        '¿Cómo te gustaría empezar?',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Herramientas sencillas para acompañarte, respirar con calma y cuidar de tu bienestar emocional.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),

                // Chequeo de bienestar principal
                ActionCard(
                  icon: Icons.checklist_rtl_rounded,
                  title: 'Chequeo de bienestar',
                  description: '8 preguntas breves para guiarte hacia las mejores recomendaciones.',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WellbeingCheckScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                const SectionLabel('Ejercicios de calma'),
                const SizedBox(height: 12),
                ActionCard(
                  icon: Icons.air_rounded,
                  title: 'Ejercicio de respiración',
                  description: 'Una pausa guiada a tu propio ritmo para regular tu cuerpo.',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BreathingScreen()),
                  ),
                ),
                const SizedBox(height: 11),
                ActionCard(
                  icon: Icons.filter_center_focus_rounded,
                  title: 'Ejercicio de conexión (Grounding)',
                  description: 'Técnica 5-4-3-2-1 con tus sentidos para volver al presente.',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GroundingScreen()),
                  ),
                ),
                const SizedBox(height: 24),

                const SectionLabel('Orientación y lecturas'),
                const SizedBox(height: 12),
                ActionCard(
                  icon: Icons.article_outlined,
                  title: 'Artículos de la psicóloga',
                  description: 'Consejos prácticos para comprender la sobrecarga y el descanso.',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ArticlesScreen()),
                  ),
                ),
                const SizedBox(height: 11),
                ActionCard(
                  icon: Icons.diversity_1_rounded,
                  title: 'Acompañar a alguien',
                  description: 'Guía paso a paso para estar presente y escuchar con respeto.',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SupportSomeoneScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 26),

                // Botón Necesito ayuda ahora
                Material(
                  color: const Color(0xFFFFF1EF),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CrisisScreen()),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9DEDA),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.support_rounded,
                              color: AppColors.alerta,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Necesito ayuda ahora',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF803E3E),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Línea de la Vida (800 911 2000) y emergencias 911 disponibles 24 h.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF805F5B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: AppColors.alerta,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Respira es una herramienta de orientación general; no sustituye la evaluación ni el tratamiento de profesionales de la salud mental.',
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
