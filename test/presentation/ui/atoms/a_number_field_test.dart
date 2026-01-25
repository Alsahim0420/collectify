import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/presentation/ui/atoms/a_number_field.dart';

void main() {
  testWidgets('ANumberField debería mostrar el label correctamente',
      (tester) async {
    // Arrange
    const label = 'Test Label';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ANumberField(label: label),
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
  });

  testWidgets('ANumberField debería mostrar el initialValue correctamente',
      (tester) async {
    // Arrange
    const label = 'Test Label';
    const initialValue = 123;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ANumberField(label: label, initialValue: initialValue),
        ),
      ),
    );

    // Assert
    expect(find.text('123'), findsOneWidget);
  });

  testWidgets('ANumberField debería validar campo vacío', (tester) async {
    // Arrange
    const label = 'Test Label';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ANumberField(label: label),
        ),
      ),
    );

    final formField = tester.widget<TextFormField>(find.byType(TextFormField));
    final validationResult = formField.validator?.call('');

    // Assert
    expect(validationResult, 'Este campo es obligatorio');
  });

  testWidgets('ANumberField debería validar número inválido', (tester) async {
    // Arrange
    const label = 'Test Label';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ANumberField(label: label),
        ),
      ),
    );

    final formField = tester.widget<TextFormField>(find.byType(TextFormField));
    final validationResult = formField.validator?.call('abc');

    // Assert
    expect(validationResult, 'Ingresa un número válido');
  });

  testWidgets('ANumberField debería validar mínimo', (tester) async {
    // Arrange
    const label = 'Test Label';
    const min = 10;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ANumberField(label: label, min: min),
        ),
      ),
    );

    final formField = tester.widget<TextFormField>(find.byType(TextFormField));
    final validationResult = formField.validator?.call('5');

    // Assert
    expect(validationResult, 'El valor debe ser mayor o igual a $min');
  });

  testWidgets('ANumberField debería validar máximo', (tester) async {
    // Arrange
    const label = 'Test Label';
    const max = 100;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ANumberField(label: label, max: max),
        ),
      ),
    );

    final formField = tester.widget<TextFormField>(find.byType(TextFormField));
    final validationResult = formField.validator?.call('150');

    // Assert
    expect(validationResult, 'El valor debe ser menor o igual a $max');
  });

  testWidgets('ANumberField debería llamar onChanged con el número correcto',
      (tester) async {
    // Arrange
    const label = 'Test Label';
    int? changedValue;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ANumberField(
            label: label,
            onChanged: (value) => changedValue = value,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), '42');
    await tester.pump();

    // Assert
    expect(changedValue, 42);
  });
}
