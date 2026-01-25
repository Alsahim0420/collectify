import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';
import 'package:collectify/domain/usecases/search_lego_sets.dart';

class MockLegoRepository extends Mock implements LegoRepository {}

void main() {
  late SearchLegoSets usecase;
  late MockLegoRepository mockRepository;

  setUp(() {
    mockRepository = MockLegoRepository();
    usecase = SearchLegoSets(mockRepository);
  });

  const tQuery = 'City';
  final tLegoSets = [
    LegoSet(
      id: '1',
      name: 'City Set',
      setNumber: 12345,
      theme: 'City',
      pieces: 500,
      notes: 'Test notes',
      acquiredAt: DateTime.now(),
      collectionId: 'collection1',
    ),
  ];

  test('debería buscar sets de LEGO en el repositorio', () async {
    // Arrange
    when(() => mockRepository.search(any()))
        .thenAnswer((_) async => Right(tLegoSets));

    // Act
    final result = await usecase(tQuery);

    // Assert
    expect(result, Right(tLegoSets));
    verify(() => mockRepository.search(tQuery)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar un Failure cuando el repositorio falla', () async {
    // Arrange
    const tFailure = UnexpectedFailure('Error al buscar sets');
    when(() => mockRepository.search(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase(tQuery);

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.search(tQuery)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
