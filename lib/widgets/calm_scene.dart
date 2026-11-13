import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Momento del día que se dibuja en la escena.
enum SceneMood { amanecer, dia, atardecer, noche }

class _ScenePalette {
  const _ScenePalette({
    required this.sky,
    required this.sun,
    required this.hills,
    required this.clouds,
  });

  final List<Color> sky;
  final Color sun;
  final List<Color> hills;
  final bool clouds;
}

const _palettes = <SceneMood, _ScenePalette>{
  SceneMood.amanecer: _ScenePalette(
    sky: [Color(0xFFFFD2B3), Color(0xFFFDE6CF), Color(0xFFEAF2EF)],
    sun: Color(0xFFFFB06B),
    hills: [Color(0xFFC6DDD2), Color(0xFF9CC4B2), Color(0xFF5E9483)],
    clouds: true,
  ),
  SceneMood.dia: _ScenePalette(
    sky: [Color(0xFFB9DEEF), Color(0xFFDDEFF3), Color(0xFFF1F7F4)],
    sun: Color(0xFFFFDB7A),
    hills: [Color(0xFFB3D5C6), Color(0xFF82B5A0), Color(0xFF2D6A64)],
    clouds: true,
  ),
  SceneMood.atardecer: _ScenePalette(
    sky: [Color(0xFFF2A88A), Color(0xFFF5C6A5), Color(0xFFF8E2CC)],
    sun: Color(0xFFFF8E62),
    hills: [Color(0xFFD7AE98), Color(0xFFA98C80), Color(0xFF5E5B63)],
    clouds: true,
  ),
  SceneMood.noche: _ScenePalette(
    sky: [Color(0xFF1C3150), Color(0xFF2B4A69), Color(0xFF46678A)],
    sun: Color(0xFFF4F0DA),
    hills: [Color(0xFF3B5A72), Color(0xFF2A475C), Color(0xFF1B3242)],
    clouds: false,
  ),
};

/// Paisaje tranquilo dibujado con código (colinas, sol o luna y nubes
/// que se mueven despacio). No necesita imágenes externas.
class CalmScene extends StatefulWidget {
  const CalmScene({
    this.height = 160,
    this.mood = SceneMood.dia,
    this.borderRadius = 24,
    this.scrim = false,
    this.child,
    super.key,
  });

  final double height;
  final SceneMood mood;
  final double borderRadius;

  /// Oscurece la parte de abajo para que el texto blanco se lea bien.
  final bool scrim;

  /// Contenido opcional encima de la escena (por ejemplo, un título).
  final Widget? child;

  /// Se puede desactivar en las pruebas para que no haya animaciones infinitas.
  static bool animate = true;

  /// Escena según la hora actual.
  static SceneMood moodForNow() {
    final hora = DateTime.now().hour;
    if (hora >= 6 && hora < 10) return SceneMood.amanecer;
    if (hora >= 10 && hora < 17) return SceneMood.dia;
    if (hora >= 17 && hora < 20) return SceneMood.atardecer;
    return SceneMood.noche;
  }

  @override
  State<CalmScene> createState() => _CalmSceneState();
}

class _CalmSceneState extends State<CalmScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 40),
  );

  @override
  void initState() {
    super.initState();
    if (CalmScene.animate) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => CustomPaint(
                  painter: _ScenePainter(
                    palette: _palettes[widget.mood]!,
                    night: widget.mood == SceneMood.noche,
                    t: _controller.value,
                  ),
                ),
              ),
            ),
            if (widget.scrim)
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x1A102A26), Color(0xB3102A26)],
                  ),
                ),
              ),
            if (widget.child != null)
              Padding(
                padding: const EdgeInsets.all(20),
                child: widget.child,
              ),
          ],
        ),
      ),
    );
  }
}

class _ScenePainter extends CustomPainter {
  _ScenePainter({required this.palette, required this.night, required this.t});

  final _ScenePalette palette;
  final bool night;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final rect = Offset.zero & size;

    // Cielo
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: palette.sky,
        ).createShader(rect),
    );

    // Estrellas (solo de noche), con un brillo suave
    if (night) {
      final rnd = math.Random(7);
      for (var i = 0; i < 40; i++) {
        final x = rnd.nextDouble() * w;
        final y = rnd.nextDouble() * h * 0.55;
        final twinkle = 0.5 + 0.5 * math.sin((t * 2 * math.pi * 6) + i);
        canvas.drawCircle(
          Offset(x, y),
          0.8 + rnd.nextDouble() * 1.2,
          Paint()..color = Colors.white.withValues(alpha: 0.35 + 0.5 * twinkle),
        );
      }
    }

    // Sol o luna con un halo que "respira"
    final pulse = 1 + 0.06 * math.sin(t * 2 * math.pi * 4);
    final sunCenter = Offset(w * 0.74, h * 0.36);
    final sunRadius = h * 0.13;
    canvas.drawCircle(
      sunCenter,
      sunRadius * 2.4 * pulse,
      Paint()
        ..shader = RadialGradient(
          colors: [
            palette.sun.withValues(alpha: 0.45),
            palette.sun.withValues(alpha: 0.0),
          ],
        ).createShader(
          Rect.fromCircle(center: sunCenter, radius: sunRadius * 2.4 * pulse),
        ),
    );
    canvas.drawCircle(sunCenter, sunRadius, Paint()..color = palette.sun);

    // Nubes que se desplazan despacio
    if (palette.clouds) {
      _cloud(canvas, size, base: 0.05, y: 0.22, scale: 1.0, speed: 1);
      _cloud(canvas, size, base: 0.55, y: 0.14, scale: 0.7, speed: 2);
      _cloud(canvas, size, base: 0.85, y: 0.32, scale: 0.55, speed: 1);
    }

    // Colinas en tres capas
    for (var i = 0; i < palette.hills.length; i++) {
      final baseY = h * (0.6 + 0.12 * i);
      final amp = h * (0.07 - 0.015 * i);
      final freq = 1.3 + i * 0.6;
      final phase = i * 1.7;
      final path = Path()..moveTo(0, h);
      for (double x = 0; x <= w; x += 4) {
        final y = baseY + math.sin((x / w) * math.pi * freq + phase) * amp;
        path.lineTo(x, y);
      }
      path
        ..lineTo(w, h)
        ..close();
      canvas.drawPath(path, Paint()..color = palette.hills[i]);
    }
  }

  void _cloud(
    Canvas canvas,
    Size size, {
    required double base,
    required double y,
    required double scale,
    required int speed,
  }) {
    final w = size.width;
    final cloudW = size.height * 0.55 * scale;
    final travel = w + cloudW * 2;
    final x = ((base * w + t * travel * speed) % travel) - cloudW;
    final cy = size.height * y;
    final r = cloudW * 0.22;
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawCircle(Offset(x, cy), r, paint);
    canvas.drawCircle(Offset(x + r * 1.1, cy - r * 0.5), r * 1.25, paint);
    canvas.drawCircle(Offset(x + r * 2.3, cy), r * 0.95, paint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x - r * 0.2, cy, r * 2.8, r * 0.9),
        Radius.circular(r * 0.45),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScenePainter old) =>
      old.t != t || old.palette != palette || old.night != night;
}
