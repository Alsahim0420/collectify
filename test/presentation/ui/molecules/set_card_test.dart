import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/presentation/ui/molecules/set_card.dart';

void main() {
  final tLegoSet = LegoSet(
    id: '1',
    name: 'Test Set',
    setNumber: 12345,
    theme: 'City',
    pieces: 500,
    notes: 'Test notes',
    acquiredAt: DateTime.now(),
    collectionId: 'collection1',
  );

  testWidgets('SetCard debería mostrar el nombre del set', (tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Set'), findsOneWidget);
  });

  testWidgets('SetCard debería mostrar el número de set', (tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('#12345'), findsOneWidget);
  });

  testWidgets('SetCard debería mostrar el tema', (tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('City'), findsOneWidget);
  });

  testWidgets('SetCard debería mostrar el número de piezas', (tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('500 piezas'), findsOneWidget);
  });

  testWidgets('SetCard debería mostrar las notas cuando existen', (tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Test notes'), findsOneWidget);
  });

  testWidgets('SetCard debería llamar onTap cuando se presiona', (tester) async {
    // Arrange
    var tapped = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    // Assert
    expect(tapped, true);
  });

  testWidgets('SetCard debería mostrar el menú cuando se proporcionan callbacks',
      (tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () {},
            onEdit: () {},
            onDelete: () {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.byIcon(Icons.more_vert), findsOneWidget);
  });

  testWidgets('SetCard debería llamar onEdit cuando se selecciona editar',
      (tester) async {
    // Arrange
    var edited = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () {},
            onEdit: () => edited = true,
            onDelete: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Editar'));
    await tester.pumpAndSettle();

    // Assert
    expect(edited, true);
  });

  testWidgets('SetCard debería llamar onDelete cuando se selecciona eliminar',
      (tester) async {
    // Arrange
    var deleted = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetCard(
            set: tLegoSet,
            onTap: () {},
            onEdit: () {},
            onDelete: () => deleted = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();

    // Assert
    expect(deleted, true);
  });
}
