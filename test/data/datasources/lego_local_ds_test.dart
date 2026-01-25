import 'package:flutter_test/flutter_test.dart';
import 'package:collectify/data/datasources/lego_local_ds.dart';
import 'package:collectify/data/models/lego_set_model.dart';

void main() {
  late InMemoryLegoLocalDataSource dataSource;

  setUp(() {
    dataSource = InMemoryLegoLocalDataSource();
  });

  final tLegoSetModel = LegoSetModel(
    id: '1',
    name: 'Test Set',
    setNumber: 12345,
    theme: 'City',
    pieces: 500,
    notes: 'Test notes',
    acquiredAt: DateTime.now().toIso8601String(),
    collectionId: 'collection1',
  );

  group('getAll', () {
    test('debería retornar una lista vacía cuando no hay sets', () async {
      // Act
      final result = await dataSource.getAll();

      // Assert
      expect(result, isEmpty);
    });

    test('debería retornar todos los sets agregados', () async {
      // Arrange
      await dataSource.insert(tLegoSetModel);
      final anotherSet = LegoSetModel(
        id: '2',
        name: 'Another Set',
        setNumber: 67890,
        theme: 'Star Wars',
        pieces: 1000,
        notes: 'More notes',
        acquiredAt: DateTime.now().toIso8601String(),
        collectionId: 'collection2',
      );
      await dataSource.insert(anotherSet);

      // Act
      final result = await dataSource.getAll();

      // Assert
      expect(result.length, 2);
      expect(result.first.id, tLegoSetModel.id);
      expect(result.last.id, anotherSet.id);
    });
  });

  group('insert', () {
    test('debería insertar un set y retornarlo', () async {
      // Act
      final result = await dataSource.insert(tLegoSetModel);

      // Assert
      expect(result.id, tLegoSetModel.id);
      expect(result.name, tLegoSetModel.name);
      final allSets = await dataSource.getAll();
      expect(allSets.length, 1);
      expect(allSets.first.id, tLegoSetModel.id);
    });
  });

  group('update', () {
    test('debería actualizar un set existente', () async {
      // Arrange
      await dataSource.insert(tLegoSetModel);
      final updatedSet = LegoSetModel(
        id: tLegoSetModel.id,
        name: 'Updated Name',
        setNumber: tLegoSetModel.setNumber,
        theme: tLegoSetModel.theme,
        pieces: tLegoSetModel.pieces,
        notes: tLegoSetModel.notes,
        acquiredAt: tLegoSetModel.acquiredAt,
        collectionId: tLegoSetModel.collectionId,
      );

      // Act
      final result = await dataSource.update(updatedSet);

      // Assert
      expect(result.name, 'Updated Name');
      final allSets = await dataSource.getAll();
      expect(allSets.first.name, 'Updated Name');
    });

    test('debería lanzar un StateError cuando el set no existe', () async {
      // Arrange
      final nonExistentSet = LegoSetModel(
        id: 'non-existent',
        name: 'Test',
        setNumber: 123,
        theme: 'Test',
        pieces: 100,
        notes: 'Test',
        acquiredAt: DateTime.now().toIso8601String(),
        collectionId: 'collection1',
      );

      // Act & Assert
      expect(
        () => dataSource.update(nonExistentSet),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('delete', () {
    test('debería eliminar un set existente', () async {
      // Arrange
      await dataSource.insert(tLegoSetModel);
      final anotherSet = LegoSetModel(
        id: '2',
        name: 'Another Set',
        setNumber: 67890,
        theme: 'Star Wars',
        pieces: 1000,
        notes: 'More notes',
        acquiredAt: DateTime.now().toIso8601String(),
        collectionId: 'collection2',
      );
      await dataSource.insert(anotherSet);

      // Act
      final result = await dataSource.delete(tLegoSetModel.id);

      // Assert
      expect(result, tLegoSetModel.id);
      final allSets = await dataSource.getAll();
      expect(allSets.length, 1);
      expect(allSets.first.id, anotherSet.id);
    });

    test('debería retornar el id incluso si el set no existe', () async {
      // Act
      final result = await dataSource.delete('non-existent');

      // Assert
      expect(result, 'non-existent');
      final allSets = await dataSource.getAll();
      expect(allSets, isEmpty);
    });
  });

  group('search', () {
    test('debería buscar sets por nombre', () async {
      // Arrange
      await dataSource.insert(tLegoSetModel);
      final anotherSet = LegoSetModel(
        id: '2',
        name: 'Star Wars Set',
        setNumber: 67890,
        theme: 'Star Wars',
        pieces: 1000,
        notes: 'More notes',
        acquiredAt: DateTime.now().toIso8601String(),
        collectionId: 'collection2',
      );
      await dataSource.insert(anotherSet);

      // Act
      final result = await dataSource.search('Test');

      // Assert
      expect(result.length, 1);
      expect(result.first.name, tLegoSetModel.name);
    });

    test('debería buscar sets por tema', () async {
      // Arrange
      await dataSource.insert(tLegoSetModel);
      final anotherSet = LegoSetModel(
        id: '2',
        name: 'Star Wars Set',
        setNumber: 67890,
        theme: 'Star Wars',
        pieces: 1000,
        notes: 'More notes',
        acquiredAt: DateTime.now().toIso8601String(),
        collectionId: 'collection2',
      );
      await dataSource.insert(anotherSet);

      // Act
      final result = await dataSource.search('City');

      // Assert
      expect(result.length, 1);
      expect(result.first.theme, 'City');
    });

    test('debería buscar sets por número de set', () async {
      // Arrange
      await dataSource.insert(tLegoSetModel);
      final anotherSet = LegoSetModel(
        id: '2',
        name: 'Star Wars Set',
        setNumber: 67890,
        theme: 'Star Wars',
        pieces: 1000,
        notes: 'More notes',
        acquiredAt: DateTime.now().toIso8601String(),
        collectionId: 'collection2',
      );
      await dataSource.insert(anotherSet);

      // Act
      final result = await dataSource.search('12345');

      // Assert
      expect(result.length, 1);
      expect(result.first.setNumber, 12345);
    });

    test('debería retornar una lista vacía cuando no hay coincidencias',
        () async {
      // Arrange
      await dataSource.insert(tLegoSetModel);

      // Act
      final result = await dataSource.search('NonExistent');

      // Assert
      expect(result, isEmpty);
    });

    test('debería ser case-insensitive', () async {
      // Arrange
      await dataSource.insert(tLegoSetModel);

      // Act
      final result = await dataSource.search('city');

      // Assert
      expect(result.length, 1);
      expect(result.first.theme, 'City');
    });
  });
}
