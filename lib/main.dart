import 'package:flutter/material.dart';

import 'core_theme.dart';
import 'splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RespiraApp());
}

class RespiraApp extends StatelessWidget {
  const RespiraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Respira',
      debugShowCheckedModeBanner: false,
      theme: buildRespiraTheme(),
      home: const SplashScreen(),
    );
  }
}
