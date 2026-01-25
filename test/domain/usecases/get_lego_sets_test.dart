import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';
import 'package:collectify/domain/usecases/get_lego_sets.dart';

class MockLegoRepository extends Mock implements LegoRepository {}

void main() {
  late GetLegoSets usecase;
  late MockLegoRepository mockRepository;

  setUp(() {
    mockRepository = MockLegoRepository();
    usecase = GetLegoSets(mockRepository);
  });

  final tLegoSets = [
    LegoSet(
      id: '1',
      name: 'Test Set',
      setNumber: 12345,
      theme: 'City',
      pieces: 500,
      notes: 'Test notes',
      acquiredAt: DateTime.now(),
      collectionId: 'collection1',
    ),
    LegoSet(
      id: '2',
      name: 'Another Set',
      setNumber: 67890,
      theme: 'Star Wars',
      pieces: 1000,
      notes: 'More notes',
      acquiredAt: DateTime.now(),
      collectionId: 'collection2',
    ),
  ];

  test('debería obtener la lista de sets de LEGO del repositorio', () async {
    // Arrange
    when(() => mockRepository.getSets())
        .thenAnswer((_) async => Right(tLegoSets));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(tLegoSets));
    verify(() => mockRepository.getSets()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar un Failure cuando el repositorio falla', () async {
    // Arrange
    const tFailure = UnexpectedFailure('Error al obtener sets');
    when(() => mockRepository.getSets())
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase();

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getSets()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
