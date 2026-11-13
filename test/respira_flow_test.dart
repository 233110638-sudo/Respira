import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:respira/core_theme.dart';
import 'package:respira/data/respira_store.dart';
import 'package:respira/screens/welcome_screen.dart';

Widget _app() {
  return ChangeNotifierProvider(
    create: (_) => RespiraStore(),
    child: MaterialApp(theme: buildRespiraTheme(), home: const WelcomeScreen()),
  );
}

Future<void> _llegarAlChequeo(WidgetTester tester) async {
  await tester.pumpWidget(_app());

  expect(find.text('Respira'), findsOneWidget);
  await tester.tap(find.text('Comenzar'));
  await tester.pumpAndSettle();

  expect(find.text('Antes de empezar'), findsOneWidget);
  expect(find.text('No es un diagnóstico'), findsOneWidget);
  await tester.tap(find.byType(Checkbox));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Continuar'));
  await tester.pumpAndSettle();
}

Future<void> _responder(WidgetTester tester, String opcion, String boton) async {
  await tester.tap(find.text(opcion));
  await tester.pumpAndSettle();
  await tester.tap(find.text(boton));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('el chequeo termina en sugerencias con la recomendación del psicólogo', (
    tester,
  ) async {
    await _llegarAlChequeo(tester);

    expect(find.text('1 de 9 · últimas 2 semanas'), findsOneWidget);
    expect(find.text('Necesito ayuda ahora'), findsOneWidget);

    // No se puede avanzar sin seleccionar una respuesta.
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('1 de 9 · últimas 2 semanas'), findsOneWidget);

    for (var i = 1; i <= 8; i++) {
      expect(find.text('$i de 9 · últimas 2 semanas'), findsOneWidget);
      await _responder(tester, 'Algunos días', 'Siguiente');
    }

    // Pregunta de seguridad: la Línea de la Vida siempre está en pantalla.
    expect(find.text('9 de 9 · últimas 2 semanas'), findsOneWidget);
    expect(find.text('Línea de la Vida'), findsOneWidget);
    await _responder(tester, 'Nunca', 'Ver mis sugerencias');

    // Resultados: sin diagnóstico y con el psicólogo siempre presente.
    expect(find.text('Esto es para ti'), findsOneWidget);
    expect(find.text('Habla con un psicólogo'), findsOneWidget);
    expect(find.text('Ideas para empezar'), findsOneWidget);
    expect(find.text('Línea de la Vida'), findsNothing);
  });

  testWidgets('una respuesta de riesgo abre la ayuda y deja visible la Línea de la Vida', (
    tester,
  ) async {
    await _llegarAlChequeo(tester);

    for (var i = 1; i <= 8; i++) {
      await _responder(tester, 'Nunca', 'Siguiente');
    }

    expect(find.text('9 de 9 · últimas 2 semanas'), findsOneWidget);
    await _responder(tester, 'Algunos días', 'Ver mis sugerencias');

    // Se abre de inmediato la pantalla de ayuda.
    expect(find.text('Gracias por contarnos'), findsOneWidget);
    expect(find.text('Llamar a la Línea de la Vida'), findsOneWidget);
    expect(find.text('800 911 2000 · gratis, 24 horas'), findsOneWidget);

    // Al volver, las sugerencias muestran la Línea de la Vida y el psicólogo.
    await tester.tap(find.text('Ya estoy mejor, volver'));
    await tester.pumpAndSettle();
    expect(find.text('Esto es para ti'), findsOneWidget);
    expect(find.text('Línea de la Vida'), findsOneWidget);
    expect(find.text('Habla con un psicólogo'), findsOneWidget);
  });
}
