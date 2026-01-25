import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/data/datasources/collection_local_datasource.dart';
import 'package:collectify/data/repositories_impl/collection_repository_impl.dart';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/failures/failures.dart';

class MockCollectionLocalDataSource extends Mock
    implements CollectionLocalDataSource {}

void main() {
  late CollectionRepositoryImpl repository;
  late MockCollectionLocalDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(Collection(
      id: '',
      name: '',
      description: '',
      color: 0,
      createdAt: DateTime.now(),
    ));
  });

  setUp(() {
    mockDataSource = MockCollectionLocalDataSource();
    repository = CollectionRepositoryImpl(mockDataSource);
  });

  final tCollection = Collection(
    id: '1',
    name: 'Test Collection',
    description: 'Test Description',
    color: 0xFF000000,
    createdAt: DateTime.now(),
  );

  group('getCollections', () {
    test(
        'debería retornar una lista de colecciones cuando la fuente de datos es exitosa',
        () async {
      // Arrange
      when(() => mockDataSource.getCollections())
          .thenAnswer((_) async => [tCollection]);

      // Act
      final result = await repository.getCollections();

      // Assert
      expect(result, isA<Right<Failure, List<Collection>>>());
      result.fold(
        (l) => fail('No debería retornar un error'),
        (r) {
          expect(r.length, 1);
          expect(r.first.id, tCollection.id);
          expect(r.first.name, tCollection.name);
        },
      );
      verify(() => mockDataSource.getCollections()).called(1);
    });

    test('debería retornar un UnexpectedFailure cuando ocurre una excepción',
        () async {
      // Arrange
      when(() => mockDataSource.getCollections())
          .thenThrow(Exception('Error'));

      // Act
      final result = await repository.getCollections();

      // Assert
      expect(result, isA<Left<Failure, List<Collection>>>());
      result.fold(
        (l) => expect(l, isA<UnexpectedFailure>()),
        (r) => fail('No debería retornar éxito'),
      );
      verify(() => mockDataSource.getCollections()).called(1);
    });
  });

  group('addCollection', () {
    test('debería agregar una colección cuando la fuente de datos es exitosa',
        () async {
      // Arrange
      when(() => mockDataSource.addCollection(any()))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.addCollection(tCollection);

      // Assert
      expect(result, isA<Right<Failure, void>>());
      verify(() => mockDataSource.addCollection(tCollection)).called(1);
    });

    test('debería retornar un UnexpectedFailure cuando ocurre una excepción',
        () async {
      // Arrange
      when(() => mockDataSource.addCollection(any()))
          .thenThrow(Exception('Error'));

      // Act
      final result = await repository.addCollection(tCollection);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      result.fold(
        (l) => expect(l, isA<UnexpectedFailure>()),
        (r) => fail('No debería retornar éxito'),
      );
      verify(() => mockDataSource.addCollection(tCollection)).called(1);
    });
  });

  group('deleteCollection', () {
    test('debería eliminar una colección cuando la fuente de datos es exitosa',
        () async {
      // Arrange
      const tId = 'test-id';
      when(() => mockDataSource.deleteCollection(any()))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.deleteCollection(tId);

      // Assert
      expect(result, isA<Right<Failure, void>>());
      verify(() => mockDataSource.deleteCollection(tId)).called(1);
    });

    test('debería retornar un UnexpectedFailure cuando ocurre una excepción',
        () async {
      // Arrange
      const tId = 'test-id';
      when(() => mockDataSource.deleteCollection(any()))
          .thenThrow(Exception('Error'));

      // Act
      final result = await repository.deleteCollection(tId);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      result.fold(
        (l) => expect(l, isA<UnexpectedFailure>()),
        (r) => fail('No debería retornar éxito'),
      );
      verify(() => mockDataSource.deleteCollection(tId)).called(1);
    });
  });
}
