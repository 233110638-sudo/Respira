import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'data/respira_store.dart';
import 'splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RespiraApp());
}

class RespiraApp extends StatelessWidget {
  const RespiraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RespiraStore(),
      child: MaterialApp(
        title: 'Respira',
        debugShowCheckedModeBanner: false,
        theme: buildRespiraTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
