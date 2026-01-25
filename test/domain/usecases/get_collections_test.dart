import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/collection_repository.dart';
import 'package:collectify/domain/usecases/get_collections.dart';

class MockCollectionRepository extends Mock implements CollectionRepository {}

void main() {
  late GetCollections usecase;
  late MockCollectionRepository mockRepository;

  setUp(() {
    mockRepository = MockCollectionRepository();
    usecase = GetCollections(mockRepository);
  });

  final tCollections = [
    Collection(
      id: '1',
      name: 'Test Collection',
      description: 'Test Description',
      color: 0xFF000000,
      createdAt: DateTime.now(),
    ),
    Collection(
      id: '2',
      name: 'Another Collection',
      description: 'Another Description',
      color: 0xFFFFFFFF,
      createdAt: DateTime.now(),
    ),
  ];

  test('debería obtener la lista de colecciones del repositorio', () async {
    // Arrange
    when(() => mockRepository.getCollections())
        .thenAnswer((_) async => Right(tCollections));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(tCollections));
    verify(() => mockRepository.getCollections()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar un Failure cuando el repositorio falla', () async {
    // Arrange
    const tFailure = UnexpectedFailure('Error al obtener colecciones');
    when(() => mockRepository.getCollections())
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase();

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getCollections()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
