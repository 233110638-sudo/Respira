import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_theme.dart';
import '../data/respira_store.dart';
import '../widgets/calm_scene.dart';
import '../widgets/crisis_badge_button.dart';

class _GratitudeStep {
  const _GratitudeStep({
    required this.title,
    required this.instruction,
    required this.hint,
    required this.icon,
  });

  final String title;
  final String instruction;
  final String hint;
  final IconData icon;
}

/// Ejercicio "Tres cosas buenas": la persona escribe tres cosas
/// sencillas que salieron bien o que agradece.
class GratitudeScreen extends StatefulWidget {
  const GratitudeScreen({super.key});

  @override
  State<GratitudeScreen> createState() => _GratitudeScreenState();
}

class _GratitudeScreenState extends State<GratitudeScreen> {
  int _currentStep = 0;

  static const _steps = <_GratitudeStep>[
    _GratitudeStep(
      title: 'Algo que salió bien hoy',
      instruction: 'Piensa en un momento del día que haya sido un poco mejor que los demás.',
      hint: 'Puede ser muy sencillo: un café rico, una plática o terminar una tarea.',
      icon: Icons.wb_sunny_outlined,
    ),
    _GratitudeStep(
      title: 'Alguien o algo que agradezcas',
      instruction: 'Escribe sobre una persona, mascota o cosa que hoy te haya hecho bien.',
      hint: 'Un mensaje de un amigo, tu cama, la música o alguien que te escuchó.',
      icon: Icons.volunteer_activism_outlined,
    ),
    _GratitudeStep(
      title: 'Algo que hiciste por ti',
      instruction: 'Reconoce un esfuerzo propio, por pequeño que parezca.',
      hint: 'Levantarte, comer algo, salir a caminar o abrir esta app también cuentan.',
      icon: Icons.favorite_outline_rounded,
    ),
  ];

  final _controllers = List.generate(3, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    for (final controller in _controllers) {
      controller.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool get _canContinue => _controllers[_currentStep].text.trim().isNotEmpty;

  void _next() {
    FocusScope.of(context).unfocus();
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      context.read<RespiraStore>().addGratitude(
            [for (final c in _controllers) c.text.trim()],
          );
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
          style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textoPrincipal),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hoy encontraste tres cosas buenas:',
              style: TextStyle(fontSize: 15, color: AppColors.textoSecundario),
            ),
            const SizedBox(height: 12),
            for (final c in _controllers)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.star_rounded, size: 18, color: AppColors.calido),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        c.text.trim(),
                        style: const TextStyle(fontSize: 14.5, color: AppColors.textoPrincipal),
                      ),
                    ),
                  ],
                ),
              ),
          ],
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
    final previousCount = context.watch<RespiraStore>().gratitude.length;

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
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primario),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Tres cosas buenas',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              if (previousCount > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Lo has hecho $previousCount ${previousCount == 1 ? 'vez' : 'veces'}. ¡Sigue así!',
                    style: const TextStyle(fontSize: 13, color: AppColors.calido, fontWeight: FontWeight.w700),
                  ),
                ),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CalmScene(height: 110, mood: SceneMood.atardecer),
                      const SizedBox(height: 16),
                      Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E6E3)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: AppColors.calidoFondo,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(step.icon, size: 32, color: AppColors.calido),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          step.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textoPrincipal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          step.instruction,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15, height: 1.45, color: AppColors.textoPrincipal),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          key: ValueKey('gratitud_$_currentStep'),
                          controller: _controllers[_currentStep],
                          maxLines: 3,
                          minLines: 2,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: step.hint,
                            hintStyle: const TextStyle(fontSize: 13.5, fontStyle: FontStyle.italic),
                            filled: true,
                            fillColor: AppColors.fondo,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _canContinue ? _next : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primario,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentStep == _steps.length - 1 ? 'Guardar' : 'Siguiente',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
