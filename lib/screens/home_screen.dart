import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_theme.dart';
import '../data/respira_store.dart';
import '../data/small_steps.dart';
import '../widgets/action_card.dart';
import '../widgets/mood_check_in.dart';
import '../widgets/psychologist_card.dart';
import 'activation_screen.dart';
import 'articles_screen.dart';
import 'breathing_screen.dart';
import 'crisis_screen.dart';
import 'gratitude_screen.dart';
import 'support_someone_screen.dart';
import 'wellbeing_check_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  String get _saludo {
    final hora = DateTime.now().hour;
    if (hora < 12) return 'Buenos días';
    if (hora < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  Widget _buildHomeTabContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            _saludo,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textoSecundario,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Un paso a la vez',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textoPrincipal,
              height: 1.22,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          const MoodCheckIn(),
          const SizedBox(height: 14),
          const PsychologistCard(),
          const SizedBox(height: 14),
          const _TodayStepCard(),
          const SizedBox(height: 14),
          _HomeActionCard(
            title: 'Hacer el chequeo de bienestar',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WellbeingCheckScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToolsTabContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Herramientas',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textoPrincipal,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Actividades cortas para los días en que el ánimo pesa.',
            style: TextStyle(fontSize: 15, color: AppColors.textoSecundario),
          ),
          const SizedBox(height: 24),
          ActionCard(
            icon: Icons.directions_walk_rounded,
            title: 'Pequeños pasos',
            description: 'Marca actividades de pocos minutos y ve tu avance.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ActivationScreen()),
            ),
          ),
          const SizedBox(height: 14),
          ActionCard(
            icon: Icons.star_rounded,
            iconColor: AppColors.calido,
            iconBackground: AppColors.calidoFondo,
            title: 'Tres cosas buenas',
            description: 'Escribe tres momentos sencillos que valieron la pena.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GratitudeScreen()),
            ),
          ),
          const SizedBox(height: 14),
          ActionCard(
            icon: Icons.air_rounded,
            title: 'Respiración 4-7-8',
            description: 'Una pausa guiada para bajar el ritmo y enfocarte.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BreathingScreen()),
            ),
          ),
          const SizedBox(height: 20),
          const PsychologistCard(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: Stack(
          children: [
            // Contenido de la pestaña activa
            Positioned.fill(
              child: IndexedStack(
                index: _selectedTabIndex,
                children: [
                  _buildHomeTabContent(),
                  _buildToolsTabContent(),
                  const ArticlesScreen(isEmbedded: true),
                  const SupportSomeoneScreen(isEmbedded: true),
                ],
              ),
            ),

            // Botón flotante "Necesito ayuda ahora" alineado abajo a la derecha
            Positioned(
              right: 20,
              bottom: 20,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CrisisScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.alerta,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.alerta.withOpacity(0.32),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.call_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Necesito ayuda ahora',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE8ECE8), width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavTabItem(
              index: 0,
              label: 'Inicio',
              icon: Icons.home_rounded,
            ),
            _buildNavTabItem(
              index: 1,
              label: 'Herramientas',
              icon: Icons.spa_rounded,
            ),
            _buildNavTabItem(
              index: 2,
              label: 'Lecturas',
              icon: Icons.article_rounded,
            ),
            _buildNavTabItem(
              index: 3,
              label: 'Acompañar',
              icon: Icons.people_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTabItem({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFDCE7E2) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 20,
              color: isSelected
                  ? AppColors.textoPrincipal
                  : const Color(0xFF86928C),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? AppColors.textoPrincipal
                  : const Color(0xFF86928C),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeActionCard extends StatelessWidget {
  const _HomeActionCard({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E6E3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textoPrincipal,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textoPrincipal,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sugiere un paso pequeño distinto cada día.
class _TodayStepCard extends StatelessWidget {
  const _TodayStepCard();

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RespiraStore>();
    final steps = allSmallSteps;
    final step = steps[DateTime.now().day % steps.length];
    final done = store.isStepDone(step.id);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: done ? const Color(0xFFE8F1EC) : AppColors.calidoFondo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                done ? Icons.emoji_events_rounded : Icons.flag_rounded,
                color: done ? AppColors.primario : AppColors.calido,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                done ? '¡Paso de hoy completado!' : 'Tu paso de hoy',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            step.text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textoPrincipal,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => store.toggleStep(step.id),
                icon: Icon(done ? Icons.undo_rounded : Icons.check_rounded, size: 18),
                label: Text(done ? 'Deshacer' : 'Lo hice'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: done ? Colors.white : AppColors.calido,
                  foregroundColor: done ? AppColors.textoPrincipal : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ActivationScreen()),
                ),
                child: const Text('Ver más pasos'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
