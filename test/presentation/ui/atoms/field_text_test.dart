import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/presentation/ui/atoms/field_text.dart';

void main() {
  testWidgets('FieldText debería mostrar el label correctamente',
      (tester) async {
    // Arrange
    const label = 'Test Label';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FieldText(label: label),
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
  });

  testWidgets('FieldText debería mostrar el hint correctamente',
      (tester) async {
    // Arrange
    const label = 'Test Label';
    const hint = 'Test Hint';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FieldText(label: label, hint: hint),
        ),
      ),
    );

    // Assert
    expect(find.text(hint), findsOneWidget);
  });

  testWidgets('FieldText debería mostrar el initialValue correctamente',
      (tester) async {
    // Arrange
    const label = 'Test Label';
    const initialValue = 'Initial Value';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FieldText(label: label, initialValue: initialValue),
        ),
      ),
    );

    // Assert
    expect(find.text(initialValue), findsOneWidget);
  });

  testWidgets('FieldText debería llamar onChanged cuando se escribe',
      (tester) async {
    // Arrange
    const label = 'Test Label';
    String? changedValue;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FieldText(
            label: label,
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

  testWidgets('FieldText debería validar correctamente', (tester) async {
    // Arrange
    const label = 'Test Label';
    String? Function(String?)? validator = (value) {
      if (value == null || value.isEmpty) {
        return 'Campo requerido';
      }
      return null;
    };

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FieldText(
            label: label,
            validator: validator,
          ),
        ),
      ),
    );

    final formField = tester.widget<TextFormField>(find.byType(TextFormField));
    final validationResult = formField.validator?.call('');

    // Assert
    expect(validationResult, 'Campo requerido');
  });

  testWidgets('FieldText debería mostrar prefixIcon cuando se proporciona',
      (tester) async {
    // Arrange
    const label = 'Test Label';
    const icon = Icons.search;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FieldText(label: label, prefixIcon: Icon(icon)),
        ),
      ),
    );

    // Assert
    expect(find.byIcon(icon), findsOneWidget);
  });

  testWidgets('FieldText debería mostrar suffixIcon cuando se proporciona',
      (tester) async {
    // Arrange
    const label = 'Test Label';
    const icon = Icons.clear;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FieldText(label: label, suffixIcon: Icon(icon)),
        ),
      ),
    );

    // Assert
    expect(find.byIcon(icon), findsOneWidget);
  });
}
