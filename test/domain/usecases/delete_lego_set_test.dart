import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';
import 'package:collectify/domain/usecases/delete_lego_set.dart';

class MockLegoRepository extends Mock implements LegoRepository {}

void main() {
  late DeleteLegoSet usecase;
  late MockLegoRepository mockRepository;

  setUp(() {
    mockRepository = MockLegoRepository();
    usecase = DeleteLegoSet(mockRepository);
  });

  const tId = 'test-id-123';

  test('debería eliminar un set de LEGO del repositorio', () async {
    // Arrange
    when(() => mockRepository.deleteSet(any()))
        .thenAnswer((_) async => const Right(tId));

    // Act
    final result = await usecase(tId);

    // Assert
    expect(result, const Right(tId));
    verify(() => mockRepository.deleteSet(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar un Failure cuando el repositorio falla', () async {
    // Arrange
    const tFailure = UnexpectedFailure('Error al eliminar set');
    when(() => mockRepository.deleteSet(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase(tId);

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.deleteSet(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
