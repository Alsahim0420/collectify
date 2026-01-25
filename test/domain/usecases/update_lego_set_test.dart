import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';
import 'package:collectify/domain/usecases/update_lego_set.dart';

class MockLegoRepository extends Mock implements LegoRepository {}

void main() {
  late UpdateLegoSet usecase;
  late MockLegoRepository mockRepository;

  setUp(() {
    mockRepository = MockLegoRepository();
    usecase = UpdateLegoSet(mockRepository);
  });

  final tLegoSet = LegoSet(
    id: '1',
    name: 'Updated Set',
    setNumber: 12345,
    theme: 'City',
    pieces: 600,
    notes: 'Updated notes',
    acquiredAt: DateTime.now(),
    collectionId: 'collection1',
  );

  test('debería actualizar un set de LEGO en el repositorio', () async {
    // Arrange
    when(() => mockRepository.updateSet(any()))
        .thenAnswer((_) async => Right(tLegoSet));

    // Act
    final result = await usecase(tLegoSet);

    // Assert
    expect(result, Right(tLegoSet));
    verify(() => mockRepository.updateSet(tLegoSet)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar un Failure cuando el repositorio falla', () async {
    // Arrange
    const tFailure = UnexpectedFailure('Error al actualizar set');
    when(() => mockRepository.updateSet(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase(tLegoSet);

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.updateSet(tLegoSet)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
