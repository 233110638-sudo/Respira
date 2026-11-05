import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/crisis_badge_button.dart';
import 'crisis_screen.dart';
import 'recommendations_screen.dart';

class WellbeingCheckScreen extends StatefulWidget {
  const WellbeingCheckScreen({super.key});

  @override
  State<WellbeingCheckScreen> createState() => _WellbeingCheckScreenState();
}

class _WellbeingQuestion {
  const _WellbeingQuestion({
    required this.number,
    required this.question,
    required this.isSafetyQuestion,
  });

  final int number;
  final String question;
  final bool isSafetyQuestion;
}

class _WellbeingCheckScreenState extends State<WellbeingCheckScreen> {
  int _currentIndex = 0;
  final Map<int, int> _answers = {};

  static const _options = <String>[
    'Nunca',
    'Algunos días',
    'Más de la mitad de los días',
    'Casi todos los días',
  ];

  static const _questions = <_WellbeingQuestion>[
    _WellbeingQuestion(
      number: 1,
      question: '¿Te has sentido inquieto/a, tenso/a o con los nervios de punta?',
      isSafetyQuestion: false,
    ),
    _WellbeingQuestion(
      number: 2,
      question: '¿Te ha costado dejar de darle vueltas a lo que te preocupa?',
      isSafetyQuestion: false,
    ),
    _WellbeingQuestion(
      number: 3,
      question: '¿Has sentido que te preocupas de más por muchas cosas distintas?',
      isSafetyQuestion: false,
    ),
    _WellbeingQuestion(
      number: 4,
      question: '¿Te ha costado relajarte, incluso en tus ratos libres?',
      isSafetyQuestion: false,
    ),
    _WellbeingQuestion(
      number: 5,
      question: '¿Te has sentido tan inquieto/a que te cuesta quedarte quieto/a?',
      isSafetyQuestion: false,
    ),
    _WellbeingQuestion(
      number: 6,
      question: '¿Te has molestado o irritado con más facilidad de lo normal?',
      isSafetyQuestion: false,
    ),
    _WellbeingQuestion(
      number: 7,
      question: '¿Has sentido miedo de que algo malo pudiera pasar?',
      isSafetyQuestion: false,
    ),
    _WellbeingQuestion(
      number: 8,
      question:
          '¿Has tenido pensamientos de que estarías mejor muerto/a o de hacerte daño de alguna manera?',
      isSafetyQuestion: true,
    ),
  ];

  void _onOptionSelected(int optionIndex) {
    setState(() {
      _answers[_currentIndex] = optionIndex;
    });
  }

  void _onNext() {
    if (!_answers.containsKey(_currentIndex)) {
      return;
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _finishAssessment();
    }
  }

  void _onPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _finishAssessment() {
    final q8Answer = _answers[7] ?? 0;

    // Si respondió algo distinto a "Nunca" en la pregunta de seguridad (8), activar protocolo de crisis
    if (q8Answer > 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CrisisScreen()),
      );
      return;
    }

    // Suma de preguntas 1 a 7 (0 a 21 puntos)
    var score = 0;
    for (var i = 0; i < 7; i++) {
      score += _answers[i] ?? 0;
    }

    final resultType = score >= 10
        ? WellbeingResultType.calmAndPsychologist
        : WellbeingResultType.wellnessAndArticles;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RecommendationsScreen(resultType: resultType),
      ),
    );
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
              // Barra superior: flecha de regreso + botón rojo "Necesito ayuda ahora"
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
              // Subtítulo con progreso y contexto temporal
              Text(
                '${_currentIndex + 1} de ${_questions.length} · últimas 2 semanas',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textoSecundario,
                ),
              ),
              const SizedBox(height: 8),
              // Barra delgada de progreso
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
              // Pregunta
              Text(
                currentQ.question,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  height: 1.28,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 28),
              // Opciones de respuesta
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final isSelected = selectedOption == index;
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _onOptionSelected(index),
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFE8F1EC)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFC3DACF)
                                  : const Color(0xFFE2E6E3),
                              width: isSelected ? 1.4 : 1.0,
                            ),
                            boxShadow: isSelected
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                          ),
                          child: Row(
                            children: [
                              // Icono circular de radio
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primario
                                        : const Color(0xFF75827B),
                                    width: isSelected ? 2.2 : 1.8,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primario,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  _options[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: AppColors.textoPrincipal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Botón Siguiente
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
                  child: const Text(
                    'Siguiente',
                    style: TextStyle(
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
