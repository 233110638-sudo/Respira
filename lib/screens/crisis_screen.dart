import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core_theme.dart';

class CrisisScreen extends StatelessWidget {
  const CrisisScreen({super.key});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copiado al portapapeles: $text'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF7F7),
      appBar: AppBar(
        title: const Text('Protocolo de apoyo y crisis'),
        backgroundColor: const Color(0xFFFBF7F7),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 32),
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9DEDA),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.support_rounded,
                    color: AppColors.alerta,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'No estás a solas. Tu vida y tu seguridad son lo primero.',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF5A2424),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Si sientes que estás en peligro inmediato o estás pasando por un momento abrumador, por favor utiliza estas vías de ayuda gratuitas y disponibles las 24 horas:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4A4040),
                  ),
                ),
                const SizedBox(height: 20),

                // Botón Línea de la Vida
                _EmergencyActionCard(
                  title: 'Línea de la Vida',
                  subtitle: 'Atención psicológica y emocional gratuita, 24 horas.',
                  phoneNumber: '800 911 2000',
                  icon: Icons.phone_in_talk_rounded,
                  color: AppColors.alerta,
                  onCopy: () => _copyToClipboard(context, '8009112000', 'Número de la Línea de la Vida'),
                ),
                const SizedBox(height: 14),

                // Botón Emergencias 911
                _EmergencyActionCard(
                  title: 'Servicio de Emergencias 911',
                  subtitle: 'Si existe riesgo inmediato a tu integridad física o salud.',
                  phoneNumber: '911',
                  icon: Icons.emergency_rounded,
                  color: const Color(0xFF8B2C2C),
                  onCopy: () => _copyToClipboard(context, '911', 'Número de emergencias 911'),
                ),
                const SizedBox(height: 18),

                // Sugerencia de escribir a alguien de confianza
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE8ECE8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primarioClaro,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.people_alt_outlined, color: AppColors.primario, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Escribe a alguien de confianza',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Pídele a un amigo, familiar o persona cercana que esté contigo en este momento. Si te cuesta ponerlo en palabras, puedes copiar este mensaje:',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F8F5),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE0E5E0)),
                        ),
                        child: const Text(
                          '“Hola, estoy pasando por un momento muy difícil y necesito compañía o que me ayudes a contactar apoyo. ¿Podrías estar conmigo?”',
                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, height: 1.4),
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () => _copyToClipboard(
                          context,
                          'Hola, estoy pasando por un momento muy difícil y necesito compañía o que me ayudes a contactar apoyo. ¿Podrías estar conmigo?',
                          'Mensaje de apoyo',
                        ),
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        label: const Text('Copiar mensaje para enviar'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Recomendación de acudir con un psicólogo cuando esté a salvo
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF1EC),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFCFDFD4)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.psychology_outlined, color: AppColors.primario, size: 26),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Acude con un psicólogo cuando estés a salvo',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.textoPrincipal,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Una vez asegurada tu tranquilidad inmediata, te recomendamos acudir con un profesional de la psicología para recibir el acompañamiento continuo y especializado que mereces.',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.45),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1EF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Esta aplicación no es un servicio de emergencias ni realiza llamadas automáticas. Por favor marca a los números indicados si necesitas ayuda inmediata.',
                    style: TextStyle(fontSize: 12.5, color: Color(0xFF6E4040)),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: const Text('Volver a la pantalla anterior'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmergencyActionCard extends StatelessWidget {
  const _EmergencyActionCard({
    required this.title,
    required this.subtitle,
    required this.phoneNumber,
    required this.icon,
    required this.color,
    required this.onCopy,
  });

  final String title;
  final String subtitle;
  final String phoneNumber;
  final IconData icon;
  final Color color;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  phoneNumber,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: AppColors.textoPrincipal,
                  ),
                ),
              ),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: onCopy,
                icon: const Icon(Icons.phone_rounded, size: 18),
                label: const Text('Marcar / Copiar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
