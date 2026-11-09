import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core_theme.dart';

class CrisisScreen extends StatelessWidget {
  const CrisisScreen({super.key});

  void _copiarNumero(BuildContext context, String numero, String etiqueta) {
    Clipboard.setData(ClipboardData(text: numero));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$etiqueta copiado: $numero'),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _mostrarMensajeConfianza(BuildContext context) {
    const mensaje =
        'Hola, estoy pasando por un momento muy difícil y necesito compañía o que me ayudes a contactar apoyo. ¿Podrías estar conmigo?';

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
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
                'Escribirle a alguien de confianza',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'A veces es difícil encontrar las palabras exactas. Puedes copiar y enviar este mensaje:',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textoSecundario,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8F7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E6E3)),
                ),
                child: const Text(
                  '“$mensaje”',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14.5,
                    height: 1.45,
                    color: AppColors.textoPrincipal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: mensaje));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Mensaje copiado al portapapeles.'),
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  label: const Text('Copiar mensaje'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primario,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Título
              const Text(
                'Gracias por contarnos',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              // Subtítulo
              const Text(
                'Hay personas listas para escucharte ahora mismo.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textoSecundario,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),

              // Tarjeta 1: Línea de la Vida (Rojo sólido)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _copiarNumero(
                    context,
                    '8009112000',
                    'Número de la Línea de la Vida',
                  ),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.alerta,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.alerta.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Copiar número para llamar a la Línea de la Vida',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '800 911 2000 · gratis, 24 horas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Tarjeta 2: Copiar número para llamar al 911 (Borde rojo)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _copiarNumero(
                    context,
                    '911',
                    'Número del 911',
                  ),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.alerta, width: 1.5),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Copiar número para llamar al 911',
                          style: TextStyle(
                            color: AppColors.alerta,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Si estás en peligro inmediato',
                          style: TextStyle(
                            color: AppColors.textoSecundario,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Tarjeta 3: Escribirle a alguien de confianza (Gris suave)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _mostrarMensajeConfianza(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3F1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Escribirle a alguien de confianza',
                      style: TextStyle(
                        color: AppColors.textoPrincipal,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Enlace centrado inferior: Ya estoy mejor, volver
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'Ya estoy mejor, volver',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primario,
                        decoration: TextDecoration.underline,
                      ),
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
