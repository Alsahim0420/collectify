import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/domain/entities/lego_set.dart';

void main() {
  group('LegoSet', () {
    test('debería crear una instancia correctamente', () {
      // Arrange & Act
      final legoSet = LegoSet(
        id: '1',
        name: 'Test Set',
        setNumber: 12345,
        theme: 'City',
        pieces: 500,
        notes: 'Test notes',
        acquiredAt: DateTime.now(),
        collectionId: 'collection1',
      );

      // Assert
      expect(legoSet.id, '1');
      expect(legoSet.name, 'Test Set');
      expect(legoSet.setNumber, 12345);
      expect(legoSet.theme, 'City');
      expect(legoSet.pieces, 500);
      expect(legoSet.notes, 'Test notes');
      expect(legoSet.collectionId, 'collection1');
    });

    test('debería comparar correctamente dos instancias iguales', () {
      // Arrange
      final date = DateTime.now();
      final legoSet1 = LegoSet(
        id: '1',
        name: 'Test Set',
        setNumber: 12345,
        theme: 'City',
        pieces: 500,
        notes: 'Test notes',
        acquiredAt: date,
        collectionId: 'collection1',
      );
      final legoSet2 = LegoSet(
        id: '1',
        name: 'Test Set',
        setNumber: 12345,
        theme: 'City',
        pieces: 500,
        notes: 'Test notes',
        acquiredAt: date,
        collectionId: 'collection1',
      );

      // Assert
      expect(legoSet1, equals(legoSet2));
    });

    test('debería comparar correctamente dos instancias diferentes', () {
      // Arrange
      final legoSet1 = LegoSet(
        id: '1',
        name: 'Test Set',
        setNumber: 12345,
        theme: 'City',
        pieces: 500,
        notes: 'Test notes',
        acquiredAt: DateTime.now(),
        collectionId: 'collection1',
      );
      final legoSet2 = LegoSet(
        id: '2',
        name: 'Another Set',
        setNumber: 67890,
        theme: 'Star Wars',
        pieces: 1000,
        notes: 'More notes',
        acquiredAt: DateTime.now(),
        collectionId: 'collection2',
      );

      // Assert
      expect(legoSet1, isNot(equals(legoSet2)));
    });

    test('copyWith debería crear una nueva instancia con valores actualizados',
        () {
      // Arrange
      final legoSet = LegoSet(
        id: '1',
        name: 'Test Set',
        setNumber: 12345,
        theme: 'City',
        pieces: 500,
        notes: 'Test notes',
        acquiredAt: DateTime.now(),
        collectionId: 'collection1',
      );

      // Act
      final updatedSet = legoSet.copyWith(
        name: 'Updated Set',
        pieces: 600,
      );

      // Assert
      expect(updatedSet.id, legoSet.id);
      expect(updatedSet.name, 'Updated Set');
      expect(updatedSet.setNumber, legoSet.setNumber);
      expect(updatedSet.theme, legoSet.theme);
      expect(updatedSet.pieces, 600);
      expect(updatedSet.notes, legoSet.notes);
      expect(updatedSet.acquiredAt, legoSet.acquiredAt);
      expect(updatedSet.collectionId, legoSet.collectionId);
    });
  });
}
