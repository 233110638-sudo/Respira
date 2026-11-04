import 'package:flutter/material.dart';

import '../core_theme.dart';
import 'crisis_screen.dart';
import 'wellbeing_check_screen.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool aceptado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antes de comenzar'),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primarioClaro,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.favorite_outline_rounded,
                      color: AppColors.primario,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Tu bienestar importa',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Respira ofrece ejercicios y orientación general para acompañarte. No reemplaza una evaluación, diagnóstico ni tratamiento de profesionales de la salud.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  const _NoteCard(
                    icon: Icons.lock_outline_rounded,
                    title: 'Un espacio personal',
                    description: 'Este prototipo no crea una cuenta ni envía tus respuestas a un servicio externo.',
                  ),
                  const SizedBox(height: 12),
                  const _NoteCard(
                    icon: Icons.support_agent_rounded,
                    title: 'Pedir ayuda también es cuidarte',
                    description: 'Si estás en peligro inmediato, busca ayuda de emergencias en tu localidad o de una persona de confianza.',
                  ),
                  const SizedBox(height: 18),
                  Card(
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(color: Color(0xFFE8ECE8)),
                    ),
                    child: CheckboxListTile(
                      value: aceptado,
                      onChanged: (value) =>
                          setState(() => aceptado = value ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primario,
                      title: const Text(
                        'Entiendo el alcance de esta herramienta.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: aceptado
                          ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WellbeingCheckScreen(),
                              ),
                            )
                          : null,
                      child: const Text('Continuar'),
                    ),
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

class _NoteCard extends StatelessWidget {
  const _NoteCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

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
          Icon(icon, color: AppColors.primario),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
