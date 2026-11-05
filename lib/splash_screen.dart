import 'package:flutter/material.dart';
import 'core_theme.dart';
import 'screens/welcome_screen.dart';
import 'widgets/respira_waves.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _abrirBienvenida();
  }

  Future<void> _abrirBienvenida() async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            RespiraWaves(
              width: 70,
              height: 44,
              color: AppColors.primario,
              strokeWidth: 3.2,
            ),
            SizedBox(height: 20),
            Text(
              'Respira',
              style: TextStyle(
                color: AppColors.textoPrincipal,
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
