import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core_theme.dart';

class RespiraWaves extends StatelessWidget {
  const RespiraWaves({
    this.width = 64,
    this.height = 42,
    this.color = AppColors.primario,
    this.strokeWidth = 3.2,
    super.key,
  });

  final double width;
  final double height;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _WavesPainter(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _WavesPainter extends CustomPainter {
  _WavesPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final lineCount = 3;
    final spacing = size.height / (lineCount - 1);

    for (int i = 0; i < lineCount; i++) {
      final y = i * spacing;
      final path = Path();
      path.moveTo(0, y);

      final wavelength = size.width / 2;
      final amplitude = spacing * 0.28;

      // First wave crest/trough
      path.cubicTo(
        wavelength * 0.25,
        y - amplitude,
        wavelength * 0.25,
        y - amplitude,
        wavelength * 0.5,
        y,
      );
      path.cubicTo(
        wavelength * 0.75,
        y + amplitude,
        wavelength * 0.75,
        y + amplitude,
        wavelength,
        y,
      );

      // Second wave crest/trough
      path.cubicTo(
        wavelength + wavelength * 0.25,
        y - amplitude,
        wavelength + wavelength * 0.25,
        y - amplitude,
        wavelength + wavelength * 0.5,
        y,
      );
      path.cubicTo(
        wavelength + wavelength * 0.75,
        y + amplitude,
        wavelength + wavelength * 0.75,
        y + amplitude,
        size.width,
        y,
      );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavesPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

