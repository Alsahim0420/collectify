import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/presentation/ui/atoms/a_primary_button.dart';

void main() {
  testWidgets('PrimaryButton debería mostrar el label correctamente',
      (tester) async {
    // Arrange
    const label = 'Test Button';

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: label,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
  });

  testWidgets('PrimaryButton debería llamar onPressed cuando se presiona',
      (tester) async {
    // Arrange
    var pressed = false;
    const label = 'Test Button';

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: label,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text(label));
    await tester.pump();

    // Assert
    expect(pressed, true);
  });

  testWidgets('PrimaryButton no debería llamar onPressed cuando isLoading es true',
      (tester) async {
    // Arrange
    var pressed = false;
    const label = 'Test Button';

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: label,
            isLoading: true,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text(label));
    await tester.pump();

    // Assert
    expect(pressed, false);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('PrimaryButton debería mostrar el icono correcto', (tester) async {
    // Arrange
    const label = 'Test Button';
    const icon = Icons.add;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: label,
            icon: icon,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.byIcon(icon), findsOneWidget);
  });

  testWidgets('SecondaryButton debería mostrar el label correctamente',
      (tester) async {
    // Arrange
    const label = 'Test Button';

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            label: label,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
  });

  testWidgets('SecondaryButton debería llamar onPressed cuando se presiona',
      (tester) async {
    // Arrange
    var pressed = false;
    const label = 'Test Button';

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            label: label,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text(label));
    await tester.pump();

    // Assert
    expect(pressed, true);
  });

  testWidgets('ButtonText debería mostrar el label correctamente',
      (tester) async {
    // Arrange
    const label = 'Test Button';

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonText(
            label: label,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
  });

  testWidgets('ButtonText debería llamar onPressed cuando se presiona',
      (tester) async {
    // Arrange
    var pressed = false;
    const label = 'Test Button';

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonText(
            label: label,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text(label));
    await tester.pump();

    // Assert
    expect(pressed, true);
  });
}
