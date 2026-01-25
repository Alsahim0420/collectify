import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/presentation/ui/molecules/m_search_bar.dart' as collectify;

void main() {
  testWidgets('SearchBar debería mostrar el label correctamente',
      (tester) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: collectify.SearchBar(),
        ),
      ),
    );

    // Assert
    expect(find.text('Buscar en tu colección'), findsOneWidget);
  });

  testWidgets('SearchBar debería mostrar el hint correctamente',
      (tester) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: collectify.SearchBar(),
        ),
      ),
    );

    // Assert
    expect(find.text('Escribe el nombre o categoría...'), findsOneWidget);
  });

  testWidgets('SearchBar debería mostrar el icono de búsqueda', (tester) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: collectify.SearchBar(),
        ),
      ),
    );

    // Assert
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('SearchBar debería llamar onChanged cuando se escribe',
      (tester) async {
    // Arrange
    String? changedValue;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: collectify.SearchBar(
            onChanged: (value) => changedValue = value,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Test');
    await tester.pump();

    // Assert
    expect(changedValue, 'Test');
  });

  testWidgets('SearchBar debería mostrar el botón de limpiar cuando hay texto',
      (tester) async {
    // Arrange
    var cleared = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: collectify.SearchBar(
            initialValue: 'Test',
            onClear: () => cleared = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    // Assert
    expect(cleared, true);
  });

  testWidgets('SearchBar no debería mostrar el botón de limpiar cuando no hay texto',
      (tester) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: collectify.SearchBar(),
        ),
      ),
    );

    // Assert
    expect(find.byIcon(Icons.clear), findsNothing);
  });

  testWidgets('SearchBar debería llamar onSubmitted cuando se envía',
      (tester) async {
    // Arrange
    String? submittedValue;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: collectify.SearchBar(
            onSubmitted: (value) => submittedValue = value,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Test');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Assert
    expect(submittedValue, 'Test');
  });
}
