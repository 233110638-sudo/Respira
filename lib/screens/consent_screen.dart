import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/respira_waves.dart';
import 'wellbeing_check_screen.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool _aceptaTerminos = false;

  void _mostrarAvisoPrivacidad() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: ListView(
                controller: scrollController,
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
                    'Aviso de privacidad',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Tu privacidad y tranquilidad son fundamentales.',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Solo en tu dispositivo: Tus respuestas y registros se usan únicamente dentro de la app. No se transmiten ni almacenan en servidores externos.',
                    style: TextStyle(fontSize: 14, height: 1.45, color: AppColors.textoSecundario),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '2. Sin perfilamiento comercial: Respira no recopila datos para fines publicitarios, mercadológicos ni venta de información a terceros.',
                    style: TextStyle(fontSize: 14, height: 1.45, color: AppColors.textoSecundario),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '3. Sin historial guardado: Tus registros de ánimo y respuestas se borran al cerrar la aplicación.',
                    style: TextStyle(fontSize: 14, height: 1.45, color: AppColors.textoSecundario),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primario,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Entendido'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botón de regresar
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
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tarjeta de bienvenida
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primario, AppColors.primarioOscuro],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Column(
                          children: [
                            RespiraWaves(
                              width: 54,
                              height: 34,
                              color: Colors.white,
                              strokeWidth: 3.0,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Antes de empezar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Respira es un espacio para acompañarte en los días en que el ánimo pesa. Esto es lo que debes saber:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.5,
                                height: 1.4,
                                color: Color(0xFFE3EEEA),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const _ConsentPoint(
                        icon: Icons.medical_information_rounded,
                        title: 'No es un diagnóstico',
                        description:
                            'Las preguntas solo sirven para sugerirte herramientas. Respira no te dirá qué tienes.',
                      ),
                      const _ConsentPoint(
                        icon: Icons.psychology_rounded,
                        title: 'Siempre te recomendaremos un psicólogo',
                        description:
                            'Un profesional es quien puede acompañarte de verdad. La app es un apoyo, no un reemplazo.',
                      ),
                      const _ConsentPoint(
                        icon: Icons.phone_android_rounded,
                        title: 'Tus respuestas se quedan en tu teléfono',
                        description:
                            'No se envían a ningún servidor y se borran al cerrar la app.',
                      ),
                      const _ConsentPoint(
                        icon: Icons.call_rounded,
                        iconColor: AppColors.alerta,
                        iconBackground: AppColors.alertaFondo,
                        title: 'Ayuda en todo momento',
                        description:
                            'Con el botón "Necesito ayuda ahora" encuentras la Línea de la Vida (800 911 2000), gratis y 24 horas.',
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: GestureDetector(
                          onTap: _mostrarAvisoPrivacidad,
                          child: const Text(
                            'Leer aviso de privacidad completo',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primario,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Casilla de verificación
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _aceptaTerminos,
                      activeColor: AppColors.primario,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _aceptaTerminos = val ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Entiendo que Respira no da diagnósticos y acepto que use mis respuestas para darme sugerencias.',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: AppColors.textoPrincipal,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Botón Continuar
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _aceptaTerminos
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WellbeingCheckScreen(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primario,
                    disabledBackgroundColor: AppColors.primario.withValues(alpha: 0.4),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white.withValues(alpha: 0.8),
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continuar',
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

class _ConsentPoint extends StatelessWidget {
  const _ConsentPoint({
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor = AppColors.primario,
    this.iconBackground = AppColors.primarioClaro,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color iconColor;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borde),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textoPrincipal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    color: AppColors.textoSecundario,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
