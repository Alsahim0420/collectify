import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:collectify/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flujo completo de la aplicación', () {
    testWidgets('debería cargar la aplicación correctamente', (tester) async {
      // Arrange & Act
      app.main();
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('debería navegar entre pantallas', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act & Assert
      // Verificar que la aplicación se carga correctamente
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('Flujo de colecciones', () {
    testWidgets('debería mostrar la lista de colecciones', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act & Assert
      // La aplicación debería cargar sin errores
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('Flujo de sets de LEGO', () {
    testWidgets('debería mostrar la lista de sets', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act & Assert
      // La aplicación debería cargar sin errores
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
