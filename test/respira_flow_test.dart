import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira/core_theme.dart';
import 'package:respira/screens/welcome_screen.dart';

void main() {
  testWidgets('el flujo inicial recorre el nuevo diseño desde bienvenida hasta resultados', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: buildRespiraTheme(), home: const WelcomeScreen()),
    );

    // 1. Bienvenida (01 · Bienvenida)
    expect(find.text('Respira'), findsOneWidget);
    expect(find.text('Comenzar'), findsOneWidget);
    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    // 2. Antes de empezar (02 · Antes de empezar)
    expect(find.text('Antes de empezar'), findsOneWidget);
    expect(find.text('No es un diagnóstico'), findsOneWidget);
    expect(find.text('Tus respuestas se quedan en tu teléfono'), findsOneWidget);
    expect(find.text('Puedes borrarlas desde Ajustes'), findsOneWidget);
    expect(find.text('Leer aviso de privacidad completo'), findsOneWidget);

    // Checkbox de consentimiento
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    // 3. Chequeo de bienestar (03 · Chequeo)
    expect(find.text('1 de 8 · últimas 2 semanas'), findsOneWidget);
    expect(find.text('Necesito ayuda ahora'), findsOneWidget);

    // No se puede avanzar sin seleccionar una respuesta.
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('1 de 8 · últimas 2 semanas'), findsOneWidget);

    // Responder preguntas 1 a 7 con "Algunos días"
    for (var i = 1; i <= 7; i++) {
      expect(find.text('$i de 8 · últimas 2 semanas'), findsOneWidget);
      await tester.tap(find.text('Algunos días'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Siguiente'));
      await tester.pumpAndSettle();
    }

    // Pregunta 8 de seguridad: responder "Nunca"
    expect(find.text('8 de 8 · últimas 2 semanas'), findsOneWidget);
    await tester.tap(find.text('Nunca'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();

    // 4. Resultados (04 · Resultados)
    expect(find.text('Esto es para ti'), findsOneWidget);
    expect(find.text('Respiración 4-7-8'), findsOneWidget);
    expect(find.text('Grounding 5-4-3-2-1'), findsOneWidget);
    expect(find.text('Hablar con un psicólogo →'), findsOneWidget);
    expect(find.text('Ir al inicio'), findsOneWidget);

    // Navegación a crisis desde el botón superior
    await tester.tap(find.text('Necesito ayuda ahora'));
    await tester.pumpAndSettle();

    // 5. Necesito ayuda ahora (05 · Necesito ayuda ahora)
    expect(find.text('Gracias por contarnos'), findsOneWidget);
    expect(
      find.text('Copiar número para llamar a la Línea de la Vida'),
      findsOneWidget,
    );
    expect(find.text('800 911 2000 · gratis, 24 horas'), findsOneWidget);
    expect(find.text('Copiar número para llamar al 911'), findsOneWidget);
    expect(find.text('Escribirle a alguien de confianza'), findsOneWidget);
    expect(find.text('Ya estoy mejor, volver'), findsOneWidget);
  });

  testWidgets('respuesta de riesgo en pregunta 8 activa inmediatamente protocolo de crisis', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: buildRespiraTheme(), home: const WelcomeScreen()),
    );

    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    // Responder las primeras 7 preguntas con "Nunca"
    for (var i = 1; i <= 7; i++) {
      await tester.tap(find.text('Nunca'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Siguiente'));
      await tester.pumpAndSettle();
    }

    // En la pregunta 8 responder "Algunos días" (riesgo detectado)
    expect(find.text('8 de 8 · últimas 2 semanas'), findsOneWidget);
    await tester.tap(find.text('Algunos días'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();

    // Debe mostrar directamente la pantalla de crisis
    expect(find.text('Gracias por contarnos'), findsOneWidget);
    expect(
      find.text('Copiar número para llamar a la Línea de la Vida'),
      findsOneWidget,
    );
  });
}
