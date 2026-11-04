import 'package:flutter/material.dart';

import '../core_theme.dart';
import 'crisis_screen.dart';

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
      instruction: 'Mira a tu alrededor con detenimiento y nombra en tu mente cinco objetos.',
      hint: 'Puede ser un cuadro, una sombra, el color de una mesa, una planta o una luz.',
      icon: Icons.visibility_outlined,
    ),
    _GroundingStep(
      count: 4,
      title: '4 cosas que puedas tocar',
      instruction: 'Presta atención al contacto de cuatro texturas distintas.',
      hint: 'La tela de tu ropa, la textura de la mesa, el suelo bajo tus pies o la temperatura del aire.',
      icon: Icons.touch_app_outlined,
    ),
    _GroundingStep(
      count: 3,
      title: '3 cosas que puedas escuchar',
      instruction: 'Cierra los ojos un momento y distingue tres sonidos en el ambiente.',
      hint: 'El sonido de un vehículo a lo lejos, el reloj, el viento o el murmullo de voces.',
      icon: Icons.hearing_outlined,
    ),
    _GroundingStep(
      count: 2,
      title: '2 cosas que puedas oler',
      instruction: 'Inhala profundamente e identifica dos aromas que te rodeen.',
      hint: 'El aroma de una bebida, jabón, madera, papel o el fresco de una ventana abierta.',
      icon: Icons.air_outlined,
    ),
    _GroundingStep(
      count: 1,
      title: '1 sensación o gratitud',
      instruction: 'Nota una sensación positiva en tu cuerpo o algo que agradezcas hoy.',
      hint: 'La sensación de tus pies apoyados firmemente, el calor en tus manos o haberte regalado esta pausa.',
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
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: const Text('¡Bien hecho!'),
        content: const Text(
          'Completaste el ejercicio de conexión al presente (Grounding 5-4-3-2-1). Tómate un momento para notar cómo te sientes ahora.',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
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
      appBar: AppBar(
        title: const Text('Ejercicio de conexión (Grounding)'),
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
            constraints: const BoxConstraints(maxWidth: 540),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Paso ${_currentStep + 1} de ${_steps.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primario,
                        ),
                      ),
                      Text(
                        'Técnica 5-4-3-2-1',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 7,
                      backgroundColor: const Color(0xFFE4EEE7),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primario),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.primarioClaro,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        step.icon,
                        color: AppColors.primario,
                        size: 46,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    step.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    step.instruction,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE8ECE8)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lightbulb_outline_rounded,
                          color: AppColors.primario,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            step.hint,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      if (_currentStep > 0) ...[
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: _prev,
                            child: const Text('Anterior'),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        flex: 2,
                        child: FilledButton(
                          onPressed: _next,
                          child: Text(
                            _currentStep == _steps.length - 1
                                ? 'Finalizar ejercicio'
                                : 'Siguiente paso',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Salir del ejercicio'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

