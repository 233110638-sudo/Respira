import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/calm_scene.dart';
import '../widgets/respira_waves.dart';
import 'consent_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Icono de ondas de respiración
              const RespiraWaves(
                width: 60,
                height: 38,
                color: AppColors.primario,
                strokeWidth: 3.0,
              ),
              const SizedBox(height: 22),
              // Título Respira
              const Text(
                'Respira',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Pequeños pasos para los días en que el ánimo pesa.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textoSecundario,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              const CalmScene(height: 200, mood: SceneMood.amanecer),
              const Spacer(flex: 3),
              // Botón Comenzar
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ConsentScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primario,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Comenzar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // Texto aclaratorio inferior
              const Text(
                'Respira no da diagnósticos ni sustituye la atención de un profesional de la salud.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textoSecundario,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
