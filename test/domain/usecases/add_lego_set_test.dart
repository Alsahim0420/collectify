import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';
import 'package:collectify/domain/usecases/add_lego_set.dart';

class MockLegoRepository extends Mock implements LegoRepository {}

void main() {
  late AddLegoSet usecase;
  late MockLegoRepository mockRepository;

  setUp(() {
    mockRepository = MockLegoRepository();
    usecase = AddLegoSet(mockRepository);
  });

  final tLegoSet = LegoSet(
    id: '1',
    name: 'Test Set',
    setNumber: 12345,
    theme: 'City',
    pieces: 500,
    notes: 'Test notes',
    acquiredAt: DateTime.now(),
    collectionId: 'collection1',
  );

  test('debería agregar un set de LEGO al repositorio', () async {
    // Arrange
    when(() => mockRepository.addSet(any()))
        .thenAnswer((_) async => Right(tLegoSet));

    // Act
    final result = await usecase(tLegoSet);

    // Assert
    expect(result, Right(tLegoSet));
    verify(() => mockRepository.addSet(tLegoSet)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar un Failure cuando el repositorio falla', () async {
    // Arrange
    const tFailure = UnexpectedFailure('Error al agregar set');
    when(() => mockRepository.addSet(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase(tLegoSet);

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.addSet(tLegoSet)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
