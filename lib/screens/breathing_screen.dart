import 'dart:async';
import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/crisis_badge_button.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

enum _BreathingPhase { inhala, sosten, exhala }

class _BreathingScreenState extends State<BreathingScreen> {
  Timer? _timer;
  bool _isRunning = true;

  _BreathingPhase _currentPhase = _BreathingPhase.inhala;
  int _secondsLeftInPhase = 4;

  static const int _inhalaDuration = 4;
  static const int _sostenDuration = 7;
  static const int _exhalaDuration = 8;

  @override
  void initState() {
    super.initState();
    _startBreathingCycle();
  }

  void _startBreathingCycle() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (!_isRunning) return;

      setState(() {
        if (_secondsLeftInPhase > 1) {
          _secondsLeftInPhase--;
        } else {
          // Cambiar a la siguiente fase
          switch (_currentPhase) {
            case _BreathingPhase.inhala:
              _currentPhase = _BreathingPhase.sosten;
              _secondsLeftInPhase = _sostenDuration;
              break;
            case _BreathingPhase.sosten:
              _currentPhase = _BreathingPhase.exhala;
              _secondsLeftInPhase = _exhalaDuration;
              break;
            case _BreathingPhase.exhala:
              _currentPhase = _BreathingPhase.inhala;
              _secondsLeftInPhase = _inhalaDuration;
              break;
          }
        }
      });
    });
  }

  void _togglePause() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  String get _phaseText {
    switch (_currentPhase) {
      case _BreathingPhase.inhala:
        return 'Inhala';
      case _BreathingPhase.sosten:
        return 'Sostén';
      case _BreathingPhase.exhala:
        return 'Exhala';
    }
  }

  double get _circleScale {
    switch (_currentPhase) {
      case _BreathingPhase.inhala:
        final progress = (4 - _secondsLeftInPhase) / 4;
        return 0.82 + (0.18 * progress);
      case _BreathingPhase.sosten:
        return 1.0;
      case _BreathingPhase.exhala:
        final progress = (8 - _secondsLeftInPhase) / 8;
        return 1.0 - (0.18 * progress);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoMenta,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Barra superior: botón cerrar (X) y botón "Necesito ayuda ahora"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textoPrincipal,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const CrisisBadgeButton(),
                ],
              ),
              const SizedBox(height: 36),

              // Título centrado
              const Text(
                'Respiración 4-7-8',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),

              const Spacer(),

              // Círculo animado de respiración
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeInOut,
                  width: 230 * _circleScale,
                  height: 230 * _circleScale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primario,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primario.withOpacity(0.18),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _phaseText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_secondsLeftInPhase',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 58,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Acciones inferiores: Pausar y Terminar
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón de texto: Pausar / Reanudar
                    GestureDetector(
                      onTap: _togglePause,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          _isRunning ? 'Pausar' : 'Reanudar',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textoPrincipal,
                          ),
                        ),
                      ),
                    ),

                    // Botón cápsula: Terminar
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primario,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 15,
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Terminar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
