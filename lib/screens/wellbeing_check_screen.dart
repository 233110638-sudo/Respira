import 'package:flutter/material.dart';

import '../core_theme.dart';
import '../data/check_area.dart';
import '../widgets/crisis_badge_button.dart';
import '../widgets/lifeline_card.dart';
import 'crisis_screen.dart';
import 'recommendations_screen.dart';

class WellbeingCheckScreen extends StatefulWidget {
  const WellbeingCheckScreen({super.key});

  @override
  State<WellbeingCheckScreen> createState() => _WellbeingCheckScreenState();
}

class _WellbeingQuestion {
  const _WellbeingQuestion({required this.question, required this.area});

  final String question;
  final CheckArea area;

  bool get isSafetyQuestion => area == CheckArea.seguridad;
}

class _AnswerOption {
  const _AnswerOption(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _WellbeingCheckScreenState extends State<WellbeingCheckScreen> {
  int _currentIndex = 0;
  final Map<int, int> _answers = {};

  static const _options = <_AnswerOption>[
    _AnswerOption('Nunca', Icons.wb_sunny_rounded),
    _AnswerOption('Algunos días', Icons.wb_twilight_rounded),
    _AnswerOption('Más de la mitad de los días', Icons.cloud_rounded),
    _AnswerOption('Casi todos los días', Icons.thunderstorm_rounded),
  ];

  // Las preguntas hablan de experiencias cotidianas. No buscan
  // etiquetar a nadie: sirven para sugerir herramientas de cuidado.
  static const _questions = <_WellbeingQuestion>[
    _WellbeingQuestion(
      question: '¿Has sentido poco interés o gusto por cosas que antes disfrutabas?',
      area: CheckArea.interes,
    ),
    _WellbeingQuestion(
      question: '¿Te has sentido decaído/a, triste o sin esperanza?',
      area: CheckArea.animo,
    ),
    _WellbeingQuestion(
      question: '¿Has notado cambios en tu sueño, como dormir mucho más o mucho menos?',
      area: CheckArea.descanso,
    ),
    _WellbeingQuestion(
      question: '¿Te has sentido sin energía o cansado/a aunque no hayas hecho mucho?',
      area: CheckArea.energia,
    ),
    _WellbeingQuestion(
      question: '¿Has notado que comes mucho menos o mucho más de lo habitual?',
      area: CheckArea.alimentacion,
    ),
    _WellbeingQuestion(
      question: '¿Has sido muy duro/a contigo o has sentido que no vales lo suficiente?',
      area: CheckArea.autoestima,
    ),
    _WellbeingQuestion(
      question: '¿Te ha costado concentrarte en tareas como leer, estudiar o ver una serie?',
      area: CheckArea.concentracion,
    ),
    _WellbeingQuestion(
      question: '¿Has preferido alejarte de tus amigos o tu familia?',
      area: CheckArea.conexion,
    ),
    _WellbeingQuestion(
      question:
          '¿Has tenido pensamientos de acabar con tu vida o de hacerte daño de alguna manera?',
      area: CheckArea.seguridad,
    ),
  ];

  void _onOptionSelected(int optionIndex) {
    setState(() {
      _answers[_currentIndex] = optionIndex;
    });
  }

  void _onNext() {
    if (!_answers.containsKey(_currentIndex)) return;

    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      _finishAssessment();
    }
  }

  void _onPrevious() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    } else {
      Navigator.pop(context);
    }
  }

  void _finishAssessment() {
    final safetyIndex = _questions.indexWhere((q) => q.isSafetyQuestion);
    final safetyConcern = (_answers[safetyIndex] ?? 0) > 0;

    // Áreas donde la persona marcó "Más de la mitad de los días" o más.
    // Solo se usan para elegir sugerencias, no se muestran como resultado.
    final focusAreas = <CheckArea>[
      for (var i = 0; i < _questions.length; i++)
        if (!_questions[i].isSafetyQuestion && (_answers[i] ?? 0) >= 2)
          _questions[i].area,
    ];

    final navigator = Navigator.of(context);
    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (_) => RecommendationsScreen(
          focusAreas: focusAreas,
          safetyConcern: safetyConcern,
        ),
      ),
    );

    // Si respondió algo distinto a "Nunca" en la pregunta de seguridad,
    // se abre de inmediato la pantalla de ayuda con la Línea de la Vida.
    if (safetyConcern) {
      navigator.push(
        MaterialPageRoute(builder: (_) => const CrisisScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[_currentIndex];
    final selectedOption = _answers[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

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
                    onPressed: _onPrevious,
                  ),
                  const CrisisBadgeButton(),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '${_currentIndex + 1} de ${_questions.length} · últimas 2 semanas',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textoSecundario,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: progress),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, _) => LinearProgressIndicator(
                    value: value,
                    minHeight: 5,
                    backgroundColor: const Color(0xFFDCE7E2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primario,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Pregunta con transición suave al cambiar
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                layoutBuilder: (current, previous) => Stack(
                  alignment: Alignment.topLeft,
                  children: [...previous, ?current],
                ),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.08, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: Column(
                  key: ValueKey(_currentIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: currentQ.isSafetyQuestion
                            ? AppColors.alertaFondo
                            : AppColors.primarioClaro,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        currentQ.area.icon,
                        color: currentQ.isSafetyQuestion
                            ? AppColors.alerta
                            : AppColors.primario,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      currentQ.question,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textoPrincipal,
                        height: 1.28,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for (var index = 0; index < _options.length; index++) ...[
                      _OptionTile(
                        option: _options[index],
                        selected: selectedOption == index,
                        onTap: () => _onOptionSelected(index),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
              // En la pregunta de seguridad la Línea de la Vida queda fija en pantalla
              if (currentQ.isSafetyQuestion) ...[
                const SizedBox(height: 10),
                LifelineCard(
                  message: (selectedOption ?? 0) > 0
                      ? 'Gracias por tu honestidad. No estás solo/a: hay personas listas para escucharte ahora mismo.'
                      : 'Si alguna vez lo has pensado, puedes llamar en cualquier momento:',
                ),
                const SizedBox(height: 12),
              ],
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: selectedOption == null ? null : _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primario,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentIndex == _questions.length - 1
                        ? 'Ver mis sugerencias'
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

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _AnswerOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFE8F1EC) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.primario : const Color(0xFFE2E6E3),
              width: selected ? 1.6 : 1.0,
            ),
          ),
          child: Row(
            children: [
              AnimatedScale(
                scale: selected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                child: Icon(
                  option.icon,
                  size: 24,
                  color: selected ? AppColors.primario : const Color(0xFF8A968F),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  option.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: AppColors.textoPrincipal,
                  ),
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primario,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
