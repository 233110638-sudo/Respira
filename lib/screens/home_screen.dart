import 'package:flutter/material.dart';
import '../core_theme.dart';
import 'articles_screen.dart';
import 'breathing_screen.dart';
import 'crisis_screen.dart';
import 'grounding_screen.dart';
import 'support_someone_screen.dart';
import 'wellbeing_check_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  void _mostrarInfoPsicologo() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Hablar con un psicólogo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'La consulta con un profesional de la salud mental te brinda un espacio seguro, confidencial y sin juicios para entender tus emociones y adquirir herramientas personalizadas.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  color: AppColors.textoSecundario,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Si requieres orientación inmediata y gratuita las 24 horas, la Línea de la Vida (800 911 2000) cuenta con psicólogos capacitados listos para escucharte.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: AppColors.textoSecundario,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CrisisScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.alerta,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Ver líneas de ayuda disponibles'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHomeTabContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Título de bienvenida
          const Text(
            '¿Cómo quieres cuidarte\nhoy?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textoPrincipal,
              height: 1.22,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 28),

          // Tarjeta 1: Repetir chequeo de bienestar
          _HomeActionCard(
            title: 'Repetir chequeo de bienestar',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WellbeingCheckScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 14),

          // Tarjeta 2: Hablar con un psicólogo
          _HomeActionCard(
            title: 'Hablar con un psicólogo',
            onTap: _mostrarInfoPsicologo,
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesTabContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Ejercicios guiados',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textoPrincipal,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pausas conscientes para regular tu sistema nervioso y conectar con el presente.',
            style: TextStyle(fontSize: 15, color: AppColors.textoSecundario),
          ),
          const SizedBox(height: 24),
          _HomeActionCard(
            title: 'Respiración 4-7-8',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BreathingScreen()),
              );
            },
          ),
          const SizedBox(height: 14),
          _HomeActionCard(
            title: 'Grounding 5-4-3-2-1',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GroundingScreen()),
              );
            },
          ),
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
                  _buildExercisesTabContent(),
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
              label: 'Ejercicios',
              icon: Icons.spa_rounded,
            ),
            _buildNavTabItem(
              index: 2,
              label: 'Artículos',
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
