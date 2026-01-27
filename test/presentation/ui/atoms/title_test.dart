import 'package:flutter/material.dart' hide Title;
import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/presentation/ui/atoms/title.dart';
import 'package:collectify/presentation/ui/atoms/subtitle.dart';
import 'package:collectify/presentation/ui/atoms/body.dart';

void main() {
  testWidgets('Title debería mostrar el texto correctamente', (tester) async {
    // Arrange
    const text = 'Test Title';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Title(text)),
      ),
    );

    // Assert
    expect(find.text(text), findsOneWidget);
  });

  testWidgets('Title debería aplicar el color correcto', (tester) async {
    // Arrange
    const text = 'Test Title';
    const color = Colors.red;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Title(text, color: color)),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(text));
    expect(textWidget.style?.color, color);
  });

  testWidgets('Subtitle debería mostrar el texto correctamente', (tester) async {
    // Arrange
    const text = 'Test Subtitle';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Subtitle(text)),
      ),
    );

    // Assert
    expect(find.text(text), findsOneWidget);
  });

  testWidgets('Subtitle debería aplicar el color correcto', (tester) async {
    // Arrange
    const text = 'Test Subtitle';
    const color = Colors.blue;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Subtitle(text, color: color)),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(text));
    expect(textWidget.style?.color, color);
  });

  testWidgets('Body debería mostrar el texto correctamente', (tester) async {
    // Arrange
    const text = 'Test Body';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Body(text)),
      ),
    );

    // Assert
    expect(find.text(text), findsOneWidget);
  });

  testWidgets('Body debería aplicar el color correcto', (tester) async {
    // Arrange
    const text = 'Test Body';
    const color = Colors.green;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Body(text, color: color)),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(text));
    expect(textWidget.style?.color, color);
  });

  testWidgets('Title debería aplicar textAlign correctamente', (tester) async {
    // Arrange
    const text = 'Test Title';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Title(text, textAlign: TextAlign.center),
        ),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(text));
    expect(textWidget.textAlign, TextAlign.center);
  });
}
