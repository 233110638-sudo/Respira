import 'dart:async';

import 'package:flutter/material.dart';

import '../core_theme.dart';
import 'crisis_screen.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  Timer? _timer;
  int _second = 0;
  bool _running = false;

  static const _phases = <String>['Inhala', 'Sostén', 'Exhala', 'Descansa'];
  int get _phaseIndex => (_second ~/ 4) % _phases.length;
  int get _secondsRemaining => 4 - (_second % 4);
  double get _scale {
    final progress = (_second % 4) / 4;
    switch (_phaseIndex) {
      case 0:
        return 0.72 + (0.28 * progress);
      case 1:
        return 1;
      case 2:
        return 1 - (0.28 * progress);
      default:
        return 0.72;
    }
  }

  void _toggle() {
    if (_running) {
      _timer?.cancel();
      setState(() => _running = false);
      return;
    }
    setState(() => _running = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _second = (_second + 1) % 16);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio de respiración'),
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
                children: [
                  Text(
                    'Vamos a respirar juntos',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sigue el ritmo solo si te resulta cómodo. Puedes parar en cualquier momento.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeInOut,
                        width: 210 * _scale,
                        height: 210 * _scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primarioClaro,
                          border: Border.all(
                            color: AppColors.primario.withValues(alpha: 0.25),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primario.withValues(alpha: 0.08),
                              blurRadius: 28,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _running ? _phases[_phaseIndex] : 'A tu ritmo',
                              style: const TextStyle(
                                color: AppColors.primario,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (_running) ...[
                              const SizedBox(height: 6),
                              Text(
                                '$_secondsRemaining',
                                style: const TextStyle(
                                  color: AppColors.textoSecundario,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _running
                        ? 'Inhala · sostén · exhala · descansa'
                        : 'Un ciclo suave de cuatro tiempos',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _toggle,
                      icon: Icon(
                        _running
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                      label: Text(
                        _running ? 'Pausar ejercicio' : 'Comenzar ejercicio',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Terminar y volver'),
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
