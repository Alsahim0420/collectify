import 'package:collectify/domain/types/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/data/datasources/lego_local_datasource.dart';
import 'package:collectify/data/models/lego_set_model.dart';
import 'package:collectify/data/repositories_impl/lego_repository_impl.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';

class MockLegoLocalDataSource extends Mock implements LegoLocalDataSource {}

void main() {
  late LegoRepositoryImpl repository;
  late MockLegoLocalDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(LegoSetModel(
      id: '',
      name: '',
      setNumber: 0,
      theme: '',
      pieces: 0,
      notes: '',
      acquiredAt: DateTime.now().toIso8601String(),
      collectionId: '',
    ));
  });

  setUp(() {
    mockDataSource = MockLegoLocalDataSource();
    repository = LegoRepositoryImpl(mockDataSource);
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

  final tLegoSet = tLegoSetModel.toEntity();

  group('getSets', () {
    test('debería retornar una lista de sets cuando la fuente de datos es exitosa',
        () async {
      // Arrange
      when(() => mockDataSource.getAll())
          .thenAnswer((_) async => [tLegoSetModel]);

      // Act
      final result = await repository.getSets();

      // Assert
      expect(result, isA<Right<Failure, List<LegoSet>>>());
      result.fold(
        (l) => fail('No debería retornar un error'),
        (r) {
          expect(r.length, 1);
          expect(r.first.id, tLegoSet.id);
          expect(r.first.name, tLegoSet.name);
        },
      );
      verify(() => mockDataSource.getAll()).called(1);
    });

    test('debería retornar un UnexpectedFailure cuando ocurre una excepción',
        () async {
      // Arrange
      when(() => mockDataSource.getAll()).thenThrow(Exception('Error'));

      // Act
      final result = await repository.getSets();

      // Assert
      expect(result, isA<Left<Failure, List<LegoSet>>>());
      result.fold(
        (l) => expect(l, isA<UnexpectedFailure>()),
        (r) => fail('No debería retornar éxito'),
      );
      verify(() => mockDataSource.getAll()).called(1);
    });
  });

  group('addSet', () {
    test('debería agregar un set cuando la fuente de datos es exitosa',
        () async {
      // Arrange
      when(() => mockDataSource.insert(any()))
          .thenAnswer((_) async => tLegoSetModel);

      // Act
      final result = await repository.addSet(tLegoSet);

      // Assert
      expect(result, isA<Right<Failure, LegoSet>>());
      result.fold(
        (l) => fail('No debería retornar un error'),
        (r) {
          expect(r.id, tLegoSet.id);
          expect(r.name, tLegoSet.name);
        },
      );
      verify(() => mockDataSource.insert(any())).called(1);
    });

    test('debería retornar un UnexpectedFailure cuando ocurre una excepción',
        () async {
      // Arrange
      when(() => mockDataSource.insert(any())).thenThrow(Exception('Error'));

      // Act
      final result = await repository.addSet(tLegoSet);

      // Assert
      expect(result, isA<Left<Failure, LegoSet>>());
      result.fold(
        (l) => expect(l, isA<UnexpectedFailure>()),
        (r) => fail('No debería retornar éxito'),
      );
      verify(() => mockDataSource.insert(any())).called(1);
    });
  });

  group('updateSet', () {
    test('debería actualizar un set cuando la fuente de datos es exitosa',
        () async {
      // Arrange
      when(() => mockDataSource.update(any()))
          .thenAnswer((_) async => tLegoSetModel);

      // Act
      final result = await repository.updateSet(tLegoSet);

      // Assert
      expect(result, isA<Right<Failure, LegoSet>>());
      result.fold(
        (l) => fail('No debería retornar un error'),
        (r) {
          expect(r.id, tLegoSet.id);
          expect(r.name, tLegoSet.name);
        },
      );
      verify(() => mockDataSource.update(any())).called(1);
    });

    test('debería retornar un UnexpectedFailure cuando ocurre una excepción',
        () async {
      // Arrange
      when(() => mockDataSource.update(any())).thenThrow(Exception('Error'));

      // Act
      final result = await repository.updateSet(tLegoSet);

      // Assert
      expect(result, isA<Left<Failure, LegoSet>>());
      result.fold(
        (l) => expect(l, isA<UnexpectedFailure>()),
        (r) => fail('No debería retornar éxito'),
      );
      verify(() => mockDataSource.update(any())).called(1);
    });
  });

  group('deleteSet', () {
    test('debería eliminar un set cuando la fuente de datos es exitosa',
        () async {
      // Arrange
      const tId = 'test-id';
      when(() => mockDataSource.delete(any())).thenAnswer((_) async => tId);

      // Act
      final result = await repository.deleteSet(tId);

      // Assert
      expect(result, isA<Right<Failure, String>>());
      result.fold(
        (l) => fail('No debería retornar un error'),
        (r) => expect(r, tId),
      );
      verify(() => mockDataSource.delete(tId)).called(1);
    });

    test('debería retornar un UnexpectedFailure cuando ocurre una excepción',
        () async {
      // Arrange
      const tId = 'test-id';
      when(() => mockDataSource.delete(any())).thenThrow(Exception('Error'));

      // Act
      final result = await repository.deleteSet(tId);

      // Assert
      expect(result, isA<Left<Failure, String>>());
      result.fold(
        (l) => expect(l, isA<UnexpectedFailure>()),
        (r) => fail('No debería retornar éxito'),
      );
      verify(() => mockDataSource.delete(tId)).called(1);
    });
  });

  group('search', () {
    test('debería buscar sets cuando la fuente de datos es exitosa',
        () async {
      // Arrange
      const tQuery = 'City';
      when(() => mockDataSource.search(any()))
          .thenAnswer((_) async => [tLegoSetModel]);

      // Act
      final result = await repository.search(tQuery);

      // Assert
      expect(result, isA<Right<Failure, List<LegoSet>>>());
      result.fold(
        (l) => fail('No debería retornar un error'),
        (r) {
          expect(r.length, 1);
          expect(r.first.id, tLegoSet.id);
        },
      );
      verify(() => mockDataSource.search(tQuery)).called(1);
    });

    test('debería retornar un UnexpectedFailure cuando ocurre una excepción',
        () async {
      // Arrange
      const tQuery = 'City';
      when(() => mockDataSource.search(any())).thenThrow(Exception('Error'));

      // Act
      final result = await repository.search(tQuery);

      // Assert
      expect(result, isA<Left<Failure, List<LegoSet>>>());
      result.fold(
        (l) => expect(l, isA<UnexpectedFailure>()),
        (r) => fail('No debería retornar éxito'),
      );
      verify(() => mockDataSource.search(tQuery)).called(1);
    });
  });
}
