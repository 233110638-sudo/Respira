import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/crisis_badge_button.dart';

class GroundingScreen extends StatefulWidget {
  const GroundingScreen({super.key});

  @override
  State<GroundingScreen> createState() => _GroundingScreenState();
}

class _GroundingStep {
  const _GroundingStep({
    required this.count,
    required this.title,
    required this.instruction,
    required this.hint,
    required this.icon,
  });

  final int count;
  final String title;
  final String instruction;
  final String hint;
  final IconData icon;
}

class _GroundingScreenState extends State<GroundingScreen> {
  int _currentStep = 0;

  static const _steps = <_GroundingStep>[
    _GroundingStep(
      count: 5,
      title: '5 cosas que puedas ver',
      instruction:
          'Mira a tu alrededor con calma y nota cinco objetos específicos en tu espacio.',
      hint:
          'Puede ser una planta, un patrón en la mesa, un reflejo de luz o un cuadro.',
      icon: Icons.visibility_outlined,
    ),
    _GroundingStep(
      count: 4,
      title: '4 cosas que puedas tocar',
      instruction:
          'Presta atención física al contacto con cuatro texturas o superficies.',
      hint:
          'La tela de tu ropa, la temperatura de tus manos, tus pies sobre el piso o la superficie de tu teléfono.',
      icon: Icons.touch_app_outlined,
    ),
    _GroundingStep(
      count: 3,
      title: '3 cosas que puedas escuchar',
      instruction:
          'Cierra un momento los ojos y distingue tres sonidos distintos en el ambiente.',
      hint:
          'El zumbido del aire, pájaros afuera, el paso de un auto o tu propia respiración.',
      icon: Icons.hearing_outlined,
    ),
    _GroundingStep(
      count: 2,
      title: '2 cosas que puedas oler',
      instruction:
          'Inhala con suavidad e identifica dos aromas o sensaciones olfativas presentes.',
      hint:
          'El aroma de café, jabón, madera, lluvia o el aire fresco de una ventana.',
      icon: Icons.air_outlined,
    ),
    _GroundingStep(
      count: 1,
      title: '1 sensación de gratitud o calma',
      instruction:
          'Nota una sensación de bienestar en tu cuerpo o algo que agradezcas en este momento.',
      hint:
          'El calor de un respiro profundo, estar a salvo o haberte regalado esta pausa.',
      icon: Icons.favorite_outline_rounded,
    ),
  ];

  void _next() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      _showCompletionDialog();
    }
  }

  void _prev() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  void _showCompletionDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: const Text(
          '¡Bien hecho!',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textoPrincipal,
          ),
        ),
        content: const Text(
          'Completaste el ejercicio de conexión Grounding 5-4-3-2-1. Tómate un momento para notar cómo se siente tu cuerpo ahora.',
          style: TextStyle(fontSize: 15, color: AppColors.textoSecundario),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primario,
              shape: const StadiumBorder(),
            ),
            child: const Text('Finalizar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    final progress = (_currentStep + 1) / _steps.length;

    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textoPrincipal,
                      size: 22,
                    ),
                    onPressed: _prev,
                  ),
                  const CrisisBadgeButton(),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Paso ${_currentStep + 1} de ${_steps.length}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textoSecundario,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: const Color(0xFFDCE7E2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primario,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Grounding 5-4-3-2-1',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE2E6E3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.primarioClaro,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          step.icon,
                          size: 36,
                          color: AppColors.primario,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        step.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textoPrincipal,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        step.instruction,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15.5,
                          height: 1.45,
                          color: AppColors.textoPrincipal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        step.hint,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: AppColors.textoSecundario,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primario,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentStep == _steps.length - 1
                        ? 'Finalizar'
                        : 'Siguiente',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
