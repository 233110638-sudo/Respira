import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/crisis_badge_button.dart';
import 'breathing_screen.dart';
import 'grounding_screen.dart';
import 'home_screen.dart';

enum WellbeingResultType {
  calmAndPsychologist, // Puntuación que sugiere calma y apoyo
  wellnessAndArticles, // Puntuación de bienestar general
}

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({
    this.resultType = WellbeingResultType.wellnessAndArticles,
    super.key,
  });

  final WellbeingResultType resultType;

  void _mostrarInfoPsicologo(BuildContext context) {
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
                'Acudir a terapia no significa que algo esté mal en ti; es una decisión informada de autocuidado y prevención.',
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
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primario,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Cerrar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra superior: botón "Necesito ayuda ahora" a la derecha
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CrisisBadgeButton(),
                ],
              ),
              const SizedBox(height: 24),
              // Título
              const Text(
                'Esto es para ti',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 24),
              // Tarjeta Respiración 4-7-8
              _RecommendationCard(
                title: 'Respiración 4-7-8',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BreathingScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),
              // Tarjeta Grounding 5-4-3-2-1
              _RecommendationCard(
                title: 'Grounding 5-4-3-2-1',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GroundingScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Enlace Hablar con un psicólogo
              GestureDetector(
                onTap: () => _mostrarInfoPsicologo(context),
                child: const Text(
                  'Hablar con un psicólogo →',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primario,
                  ),
                ),
              ),
              const Spacer(),
              // Enlace centrado inferior: Ir al inicio
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
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
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({
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
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E6E3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textoPrincipal,
            ),
          ),
        ),
      ),
    );
  }
}
