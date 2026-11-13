import 'package:flutter/material.dart';
import '../core_theme.dart';
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
                    '1. Almacenamiento local: Todas tus respuestas y registros permanecen estrictamente guardados en la memoria local de tu dispositivo. No se transmiten ni almacenan en servidores externos.',
                    style: TextStyle(fontSize: 14, height: 1.45, color: AppColors.textoSecundario),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '2. Sin perfilamiento comercial: Respira no recopila datos para fines publicitarios, mercadológicos ni venta de información a terceros.',
                    style: TextStyle(fontSize: 14, height: 1.45, color: AppColors.textoSecundario),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '3. Control absoluto: Puedes eliminar el historial de respuestas en cualquier momento desde los ajustes de la aplicación.',
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
              const SizedBox(height: 28),
              // Título
              const Text(
                'Antes de empezar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 28),
              // Puntos informativos
              const Text(
                'No es un diagnóstico',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Tus respuestas se quedan en tu teléfono',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Puedes borrarlas desde Ajustes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 24),
              // Enlace al aviso de privacidad
              GestureDetector(
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
              const Spacer(),
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
                      'Acepto que Respira use mis respuestas para darme recomendaciones.',
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
