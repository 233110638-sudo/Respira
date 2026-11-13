import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_theme.dart';
import '../data/respira_store.dart';
import '../data/small_steps.dart';
import '../widgets/crisis_badge_button.dart';

/// "Pequeños pasos": lista de actividades breves que la persona
/// puede marcar como hechas.
class ActivationScreen extends StatelessWidget {
  const ActivationScreen({super.key});

  String _mensaje(int hechos) {
    if (hechos == 0) return 'Elige solo uno. Empezar ya es un logro.';
    if (hechos == 1) return '¡Diste el primer paso! Eso cuenta mucho.';
    if (hechos < 4) return 'Vas muy bien. Cada paso pequeño suma.';
    return '¡Mira todo lo que hiciste hoy! Reconócelo.';
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RespiraStore>();
    final total = allSmallSteps.length;
    final hechos = store.completedStepsCount;

    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
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
                  onPressed: () => Navigator.pop(context),
                ),
                const CrisisBadgeButton(),
              ],
            ),
            const SizedBox(height: 22),
            const Text(
              'Pequeños pasos',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textoPrincipal,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Cuando todo cuesta más trabajo, hacer algo pequeño puede ayudar a mover el ánimo. No tienes que hacerlos todos.',
              style: TextStyle(fontSize: 15, color: AppColors.textoSecundario, height: 1.4),
            ),
            const SizedBox(height: 20),
            // Progreso del día
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.calidoFondo,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department_rounded, color: AppColors.calido),
                      const SizedBox(width: 8),
                      Text(
                        '$hechos de $total pasos',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textoPrincipal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(end: hechos / total),
                      duration: const Duration(milliseconds: 350),
                      builder: (context, value, _) => LinearProgressIndicator(
                        value: value,
                        minHeight: 8,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.calido),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _mensaje(hechos),
                    style: const TextStyle(fontSize: 13.5, color: AppColors.textoPrincipal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            for (final group in stepGroups) ...[
              Row(
                children: [
                  Icon(group.icon, size: 20, color: AppColors.primario),
                  const SizedBox(width: 8),
                  Text(
                    group.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textoPrincipal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              for (final step in group.steps) ...[
                _StepTile(
                  step: step,
                  done: store.isStepDone(step.id),
                  onTap: () => store.toggleStep(step.id),
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 14),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.step, required this.done, required this.onTap});

  final SmallStep step;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: done ? const Color(0xFFE8F1EC) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: done ? AppColors.primario : AppColors.borde,
            ),
          ),
          child: Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                  key: ValueKey(done),
                  color: done ? AppColors.primario : const Color(0xFF9AA59F),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  step.text,
                  style: TextStyle(
                    fontSize: 14.5,
                    color: AppColors.textoPrincipal,
                    fontWeight: done ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${step.minutes} min',
                style: const TextStyle(fontSize: 12, color: AppColors.textoSecundario),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
