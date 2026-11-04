import 'package:flutter/material.dart';

import '../core_theme.dart';
import 'crisis_screen.dart';

class SupportSomeoneScreen extends StatelessWidget {
  const SupportSomeoneScreen({super.key});

  static const pasos = <_SupportTip>[
    _SupportTip(
      Icons.chat_bubble_outline_rounded,
      'Acércate con calma',
      'Elige un momento tranquilo y pregunta cómo está, sin presionar para que responda.',
    ),
    _SupportTip(
      Icons.hearing_rounded,
      'Escucha sin juzgar',
      'Deja que cuente lo que quiera. Puedes decir: “Gracias por confiar en mí”.',
    ),
    _SupportTip(
      Icons.help_outline_rounded,
      'Pregunta qué necesita',
      'En lugar de asumir, prueba con: “¿Qué podría ayudarte ahora?”.',
    ),
    _SupportTip(
      Icons.handshake_outlined,
      'Ofrece ayuda concreta',
      'Acompañar a una cita o volver a escribir mañana puede ser un apoyo práctico.',
    ),
    _SupportTip(
      Icons.shield_outlined,
      'Cuida la seguridad',
      'Si hay peligro inmediato, busca ayuda de emergencias de tu localidad. No cargues esto a solas.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acompañar a alguien'),
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
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estar presente puede hacer diferencia',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No necesitas tener todas las respuestas. A veces escuchar y acompañar es un buen comienzo.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 22),
                      for (var index = 0; index < pasos.length; index++) ...[
                        _TipCard(number: index + 1, tip: pasos[index]),
                        const SizedBox(height: 11),
                      ],
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primarioClaro,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Recuerda cuidar también de ti. Puedes buscar orientación profesional para saber cómo acompañar.',
                        ),
                      ),
                    ],
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

class _SupportTip {
  const _SupportTip(this.icon, this.title, this.description);

  final IconData icon;
  final String title;
  final String description;
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.number, required this.tip});

  final int number;
  final _SupportTip tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primarioClaro,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(tip.icon, color: AppColors.primario),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$number. ${tip.title}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Text(
                  tip.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
