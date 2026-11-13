import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core_theme.dart';

/// Tarjeta con el número de la Línea de la Vida.
/// Al tocarla se copia el número para poder marcarlo.
class LifelineCard extends StatelessWidget {
  const LifelineCard({this.message, super.key});

  /// Texto opcional que se muestra arriba del número.
  final String? message;

  static const numero = '8009112000';

  void _copiar(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: numero));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Número de la Línea de la Vida copiado: 800 911 2000'),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _copiar(context),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.alertaFondo,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFF3CFCB), width: 1.2),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: AppColors.alerta,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message != null) ...[
                      Text(
                        message!,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.35,
                          color: AppColors.textoPrincipal,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                    const Text(
                      'Línea de la Vida',
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.alerta,
                      ),
                    ),
                    const Text(
                      '800 911 2000 · gratis, 24 horas',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textoPrincipal,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.copy_rounded,
                size: 18,
                color: AppColors.alerta,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
