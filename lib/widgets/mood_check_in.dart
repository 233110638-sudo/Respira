import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_theme.dart';
import '../data/respira_store.dart';

const moodIcons = <IconData>[
  Icons.sentiment_very_dissatisfied_rounded,
  Icons.sentiment_dissatisfied_rounded,
  Icons.sentiment_neutral_rounded,
  Icons.sentiment_satisfied_rounded,
  Icons.sentiment_very_satisfied_rounded,
];

const moodLabels = <String>['Muy bajo', 'Bajo', 'Regular', 'Bien', 'Muy bien'];

/// Mensajes de acompañamiento según el ánimo elegido.
/// No interpretan ni diagnostican: solo acompañan y sugieren cuidarse.
const _moodMessages = <String>[
  'Gracias por contarlo. Hoy no tienes que poder con todo: elige un paso muy pequeño y, si puedes, habla con alguien de confianza o con un psicólogo.',
  'Hay días pesados. Prueba con una actividad breve de "Pequeños pasos" y recuerda que pedir ayuda profesional es una buena decisión.',
  'Un día regular también cuenta. ¿Qué tal una pausa de respiración o anotar algo que salió bien?',
  'Qué bueno que hoy te sientes bien. Nota qué te ayudó para repetirlo otros días.',
  '¡Qué gusto! Aprovecha la energía para hacer algo que disfrutes o compartirla con alguien.',
];

/// Registro de ánimo del día con caritas interactivas.
class MoodCheckIn extends StatelessWidget {
  const MoodCheckIn({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RespiraStore>();
    final today = store.todayMood;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borde),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¿Cómo está tu ánimo hoy?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textoPrincipal,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < moodIcons.length; i++)
                _MoodButton(
                  level: i,
                  selected: today?.level == i,
                  onTap: () => store.registerMood(i),
                ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: today == null
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.animo[today.level].withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        _moodMessages[today.level],
                        style: const TextStyle(
                          fontSize: 13.5,
                          height: 1.4,
                          color: AppColors.textoPrincipal,
                        ),
                      ),
                    ),
                  ),
          ),
          if (store.moods.length > 1) ...[
            const SizedBox(height: 14),
            const Text(
              'Tus últimos registros',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textoSecundario,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (final entry in store.moods.reversed.take(7))
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(
                      moodIcons[entry.level],
                      size: 22,
                      color: AppColors.animo[entry.level],
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({
    required this.level,
    required this.selected,
    required this.onTap,
  });

  final int level;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.animo[level];
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          AnimatedScale(
            scale: selected ? 1.18 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: selected ? color : color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                moodIcons[level],
                size: 28,
                color: selected ? Colors.white : color,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            moodLabels[level],
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
              color: selected ? AppColors.textoPrincipal : AppColors.textoSecundario,
            ),
          ),
        ],
      ),
    );
  }
}
