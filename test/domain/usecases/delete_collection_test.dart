import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/collection_repository.dart';
import 'package:collectify/domain/usecases/delete_collection.dart';

class MockCollectionRepository extends Mock implements CollectionRepository {}

void main() {
  late DeleteCollection usecase;
  late MockCollectionRepository mockRepository;

  setUp(() {
    mockRepository = MockCollectionRepository();
    usecase = DeleteCollection(mockRepository);
  });

  const tId = 'test-collection-id';

  test('debería eliminar una colección del repositorio', () async {
    // Arrange
    when(() => mockRepository.deleteCollection(any()))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(tId);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.deleteCollection(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar un Failure cuando el repositorio falla', () async {
    // Arrange
    const tFailure = UnexpectedFailure('Error al eliminar colección');
    when(() => mockRepository.deleteCollection(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase(tId);

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.deleteCollection(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
