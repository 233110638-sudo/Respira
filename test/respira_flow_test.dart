import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira/core_theme.dart';
import 'package:respira/screens/welcome_screen.dart';

void main() {
  testWidgets('el flujo inicial recorre el cuestionario y muestra recomendaciones', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: buildRespiraTheme(), home: const WelcomeScreen()),
    );

    // 1. Bienvenida
    expect(find.text('Un espacio para volver a ti'), findsOneWidget);
    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    // 2. Consentimiento
    expect(find.text('Tu bienestar importa'), findsOneWidget);
    await tester.ensureVisible(find.byType(CheckboxListTile));
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();
    expect(
      tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
      isTrue,
    );
    await tester.ensureVisible(find.text('Continuar'));
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    // 3. Chequeo de bienestar - 8 preguntas con barra de progreso
    expect(find.text('Pregunta 1 de 8'), findsOneWidget);
    expect(find.text('Piensa en las últimas 2 semanas'), findsOneWidget);

    // Responder las primeras 7 preguntas con "Algunos días"
    for (var i = 1; i <= 7; i++) {
      expect(find.text('Pregunta $i de 8'), findsOneWidget);
      await tester.tap(find.text('Algunos días'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Siguiente pregunta'));
      await tester.pumpAndSettle();
    }

    // Pregunta 8 (Seguridad): responder "Nunca"
    expect(find.text('Pregunta 8 de 8'), findsOneWidget);
    await tester.tap(find.text('Nunca'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ver recomendaciones'));
    await tester.pumpAndSettle();

    // 4. Recomendaciones
    // Score = 7 (0-9 puntos) -> Ejercicios de bienestar y artículos
    expect(find.text('Espacios para tu bienestar'), findsOneWidget);
    expect(find.text('Ejercicio de respiración'), findsOneWidget);
    expect(find.text('Ejercicio de conexión (Grounding 5-4-3-2-1)'), findsOneWidget);
    expect(find.text('Artículos de nuestra psicóloga'), findsOneWidget);
    expect(find.text('La consulta psicológica como prevención'), findsOneWidget);

    // Probar navegación a la pantalla de crisis desde ayuda
    await tester.ensureVisible(find.text('¿Necesitas ayuda inmediata?'));
    await tester.tap(find.text('¿Necesitas ayuda inmediata?'));
    await tester.pumpAndSettle();

    // 5. Protocolo de crisis
    expect(find.text('Protocolo de apoyo y crisis'), findsOneWidget);
    expect(find.text('800 911 2000'), findsOneWidget);
    expect(find.text('911'), findsOneWidget);
  });

  testWidgets('respuesta de riesgo en pregunta 8 activa inmediatamente protocolo de crisis', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: buildRespiraTheme(), home: const WelcomeScreen()),
    );

    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    // Responder las primeras 7 con "Nunca"
    for (var i = 1; i <= 7; i++) {
      await tester.tap(find.text('Nunca'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Siguiente pregunta'));
      await tester.pumpAndSettle();
    }

    // En la pregunta 8 responder "Algunos días" (distinta de Nunca)
    expect(find.text('Pregunta 8 de 8'), findsOneWidget);
    await tester.tap(find.text('Algunos días'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ver recomendaciones'));
    await tester.pumpAndSettle();

    // Debe abrir directamente la pantalla de crisis
    expect(find.text('Protocolo de apoyo y crisis'), findsOneWidget);
    expect(find.text('Línea de la Vida'), findsOneWidget);
  });
}
