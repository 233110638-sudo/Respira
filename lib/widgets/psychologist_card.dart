import 'package:flutter/material.dart';

import '../core_theme.dart';
import '../screens/crisis_screen.dart';

/// Muestra la información para buscar a un psicólogo.
void showPsychologistSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
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
                'Un psicólogo te ofrece un espacio seguro, confidencial y sin juicios para hablar de lo que sientes y encontrar herramientas hechas a tu medida.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  color: AppColors.textoSecundario,
                ),
              ),
              const SizedBox(height: 16),
              const _SheetStep(
                icon: Icons.school_rounded,
                text:
                    'Pregunta en tu escuela o trabajo: muchos cuentan con atención psicológica gratuita.',
              ),
              const _SheetStep(
                icon: Icons.local_hospital_rounded,
                text:
                    'Acude a tu centro de salud o clínica más cercana y pide orientación psicológica.',
              ),
              const _SheetStep(
                icon: Icons.call_rounded,
                text:
                    'Llama a la Línea de la Vida (800 911 2000). Es gratis, 24 horas, y te pueden orientar.',
              ),
              const SizedBox(height: 8),
              const Text(
                'Buscar ayuda no significa que algo esté mal en ti: es una forma de cuidarte.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CrisisScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.alerta,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Ver líneas de ayuda'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _SheetStep extends StatelessWidget {
  const _SheetStep({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.psicologoFondo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.psicologo),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textoPrincipal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Recomendación de acudir con un psicólogo.
/// Se muestra siempre, sin importar las respuestas.
class PsychologistCard extends StatelessWidget {
  const PsychologistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => showPsychologistSheet(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.psicologoFondo,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFD3DEEE)),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.psicologo,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RECOMENDACIÓN IMPORTANTE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: AppColors.psicologo,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Habla con un psicólogo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textoPrincipal,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Te recomendamos acudir con un profesional. Toca para ver cómo empezar.',
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: AppColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.psicologo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
