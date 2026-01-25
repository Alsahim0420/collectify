import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collectify/data/datasources/collection_local_datasource_impl.dart';
import 'package:collectify/domain/entities/collection.dart';

void main() {
  late CollectionLocalDataSourceImpl dataSource;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    dataSource = CollectionLocalDataSourceImpl(prefs);
  });

  tearDown(() async {
    await prefs.clear();
  });

  final tCollection = Collection(
    id: '1',
    name: 'Test Collection',
    description: 'Test Description',
    color: 0xFF000000,
    createdAt: DateTime.now(),
  );

  group('getCollections', () {
    test('debería retornar una lista vacía cuando no hay colecciones', () async {
      // Act
      final result = await dataSource.getCollections();

      // Assert
      expect(result, isEmpty);
    });

    test('debería retornar las colecciones guardadas', () async {
      // Arrange
      await dataSource.addCollection(tCollection);
      final anotherCollection = Collection(
        id: '2',
        name: 'Another Collection',
        description: 'Another Description',
        color: 0xFFFFFFFF,
        createdAt: DateTime.now(),
      );
      await dataSource.addCollection(anotherCollection);

      // Act
      final result = await dataSource.getCollections();

      // Assert
      expect(result.length, 2);
      expect(result.first.id, tCollection.id);
      expect(result.first.name, tCollection.name);
      expect(result.last.id, anotherCollection.id);
    });
  });

  group('addCollection', () {
    test('debería agregar una colección', () async {
      // Act
      await dataSource.addCollection(tCollection);

      // Assert
      final collections = await dataSource.getCollections();
      expect(collections.length, 1);
      expect(collections.first.id, tCollection.id);
      expect(collections.first.name, tCollection.name);
    });

    test('debería agregar múltiples colecciones', () async {
      // Arrange
      await dataSource.addCollection(tCollection);
      final anotherCollection = Collection(
        id: '2',
        name: 'Another Collection',
        description: 'Another Description',
        color: 0xFFFFFFFF,
        createdAt: DateTime.now(),
      );

      // Act
      await dataSource.addCollection(anotherCollection);

      // Assert
      final collections = await dataSource.getCollections();
      expect(collections.length, 2);
    });
  });

  group('deleteCollection', () {
    test('debería eliminar una colección existente', () async {
      // Arrange
      await dataSource.addCollection(tCollection);
      final anotherCollection = Collection(
        id: '2',
        name: 'Another Collection',
        description: 'Another Description',
        color: 0xFFFFFFFF,
        createdAt: DateTime.now(),
      );
      await dataSource.addCollection(anotherCollection);

      // Act
      await dataSource.deleteCollection(tCollection.id);

      // Assert
      final collections = await dataSource.getCollections();
      expect(collections.length, 1);
      expect(collections.first.id, anotherCollection.id);
    });

    test('no debería hacer nada si la colección no existe', () async {
      // Arrange
      await dataSource.addCollection(tCollection);

      // Act
      await dataSource.deleteCollection('non-existent');

      // Assert
      final collections = await dataSource.getCollections();
      expect(collections.length, 1);
    });

    test('no debería hacer nada si no hay colecciones', () async {
      // Act
      await dataSource.deleteCollection('any-id');

      // Assert
      final collections = await dataSource.getCollections();
      expect(collections, isEmpty);
    });
  });
}
