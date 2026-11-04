import 'package:flutter/material.dart';

import '../core_theme.dart';
import 'consent_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      color: AppColors.primarioClaro,
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: const Icon(
                      Icons.spa_rounded,
                      size: 96,
                      color: AppColors.primario,
                    ),
                  ),
                  const SizedBox(height: 38),
                  Text(
                    'Un espacio para volver a ti',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Pequeños momentos de calma, orientación y apoyo para cuidar de tu bienestar emocional.',
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: AppColors.textoSecundario),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ConsentScreen(),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Comenzar'),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'A tu ritmo. Sin juicios.',
                    style: Theme.of(context).textTheme.bodySmall,
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
