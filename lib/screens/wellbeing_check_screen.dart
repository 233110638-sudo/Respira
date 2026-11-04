import 'package:flutter/material.dart';

import '../core_theme.dart';
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
    }
  }

  void _finishAssessment() {
    final q8Answer = _answers[7] ?? 0;

    // Regla: Cualquier respuesta distinta de "Nunca" en la pregunta 8 activa el protocolo de crisis
    if (q8Answer > 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CrisisScreen()),
      );
      return;
    }

    // Suma interna de las preguntas 1 a 7 (0 a 21 puntos)
    var score = 0;
    for (var i = 0; i < 7; i++) {
      score += _answers[i] ?? 0;
    }

    // Regla interna:
    // 10-21 puntos -> Ejercicios de calma y psicólogo destacado
    // 0-9 puntos -> Ejercicios de bienestar y artículos
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
    final isLastQuestion = _currentIndex == _questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chequeo de bienestar'),
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
            constraints: const BoxConstraints(maxWidth: 580),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Barra de progreso y contador
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pregunta ${_currentIndex + 1} de ${_questions.length}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primario,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primarioClaro,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Piensa en las últimas 2 semanas',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textoPrincipal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFE4EEE7),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primario),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Contenido de la pregunta
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: const Color(0xFFE8ECE8)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentQ.question,
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    height: 1.35,
                                  ),
                                ),
                                if (currentQ.isSafetyQuestion) ...[
                                  const SizedBox(height: 10),
                                  Text(
                                    'Tu bienestar y seguridad son fundamentales para nosotros.',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.alerta,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Opciones de respuesta
                          for (var i = 0; i < _options.length; i++) ...[
                            _QuestionOptionTile(
                              title: _options[i],
                              isSelected: selectedOption == i,
                              onTap: () => _onOptionSelected(i),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Barra de navegación inferior
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (_currentIndex > 0) ...[
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: _onPrevious,
                            child: const Text('Anterior'),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        flex: 2,
                        child: FilledButton(
                          onPressed: selectedOption == null ? null : _onNext,
                          child: Text(
                            isLastQuestion ? 'Ver recomendaciones' : 'Siguiente pregunta',
                          ),
                        ),
                      ),
                    ],
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

class _QuestionOptionTile extends StatelessWidget {
  const _QuestionOptionTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primarioClaro : Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? AppColors.primario : const Color(0xFFE8ECE8),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primario : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.primario : const Color(0xFFB5BEB7),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? AppColors.textoPrincipal : AppColors.textoPrincipal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
