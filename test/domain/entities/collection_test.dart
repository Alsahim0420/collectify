import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/domain/entities/collection.dart';

void main() {
  group('Collection', () {
    test('debería crear una instancia correctamente', () {
      // Arrange & Act
      final collection = Collection(
        id: '1',
        name: 'Test Collection',
        description: 'Test Description',
        color: 0xFF000000,
        createdAt: DateTime.now(),
      );

      // Assert
      expect(collection.id, '1');
      expect(collection.name, 'Test Collection');
      expect(collection.description, 'Test Description');
      expect(collection.color, 0xFF000000);
      expect(collection.setCount, 0);
    });

    test('debería crear una instancia con setCount personalizado', () {
      // Arrange & Act
      final collection = Collection(
        id: '1',
        name: 'Test Collection',
        description: 'Test Description',
        color: 0xFF000000,
        createdAt: DateTime.now(),
        setCount: 5,
      );

      // Assert
      expect(collection.setCount, 5);
    });

    test('debería comparar correctamente dos instancias iguales', () {
      // Arrange
      final date = DateTime.now();
      final collection1 = Collection(
        id: '1',
        name: 'Test Collection',
        description: 'Test Description',
        color: 0xFF000000,
        createdAt: date,
      );
      final collection2 = Collection(
        id: '1',
        name: 'Test Collection',
        description: 'Test Description',
        color: 0xFF000000,
        createdAt: date,
      );

      // Assert
      expect(collection1, equals(collection2));
    });

    test('debería comparar correctamente dos instancias diferentes', () {
      // Arrange
      final collection1 = Collection(
        id: '1',
        name: 'Test Collection',
        description: 'Test Description',
        color: 0xFF000000,
        createdAt: DateTime.now(),
      );
      final collection2 = Collection(
        id: '2',
        name: 'Another Collection',
        description: 'Another Description',
        color: 0xFFFFFFFF,
        createdAt: DateTime.now(),
      );

      // Assert
      expect(collection1, isNot(equals(collection2)));
    });

    test('copyWith debería crear una nueva instancia con valores actualizados',
        () {
      // Arrange
      final collection = Collection(
        id: '1',
        name: 'Test Collection',
        description: 'Test Description',
        color: 0xFF000000,
        createdAt: DateTime.now(),
      );

      // Act
      final updatedCollection = collection.copyWith(
        name: 'Updated Collection',
        setCount: 10,
      );

      // Assert
      expect(updatedCollection.id, collection.id);
      expect(updatedCollection.name, 'Updated Collection');
      expect(updatedCollection.description, collection.description);
      expect(updatedCollection.color, collection.color);
      expect(updatedCollection.createdAt, collection.createdAt);
      expect(updatedCollection.setCount, 10);
    });

    test('fromJson debería crear una instancia desde JSON', () {
      // Arrange
      final json = {
        'id': '1',
        'name': 'Test Collection',
        'description': 'Test Description',
        'color': 0xFF000000,
        'createdAt': DateTime.now().toIso8601String(),
        'setCount': 5,
      };

      // Act
      final collection = Collection.fromJson(json);

      // Assert
      expect(collection.id, '1');
      expect(collection.name, 'Test Collection');
      expect(collection.description, 'Test Description');
      expect(collection.color, 0xFF000000);
      expect(collection.setCount, 5);
    });

    test('toJson debería convertir una instancia a JSON', () {
      // Arrange
      final date = DateTime.now();
      final collection = Collection(
        id: '1',
        name: 'Test Collection',
        description: 'Test Description',
        color: 0xFF000000,
        createdAt: date,
        setCount: 5,
      );

      // Act
      final json = collection.toJson();

      // Assert
      expect(json['id'], '1');
      expect(json['name'], 'Test Collection');
      expect(json['description'], 'Test Description');
      expect(json['color'], 0xFF000000);
      expect(json['setCount'], 5);
      expect(json['createdAt'], date.toIso8601String());
    });
  });
}
