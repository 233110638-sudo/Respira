import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../screens/crisis_screen.dart';

class CrisisBadgeButton extends StatelessWidget {
  const CrisisBadgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CrisisScreen()),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.alerta, width: 1.2),
          ),
          child: const Text(
            'Necesito ayuda ahora',
            style: TextStyle(
              color: AppColors.alerta,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

