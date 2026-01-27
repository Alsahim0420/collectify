import 'package:collectify/domain/types/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/collection_repository.dart';
import 'package:collectify/domain/usecases/add_collection.dart';

class MockCollectionRepository extends Mock implements CollectionRepository {}

void main() {
  late AddCollection usecase;
  late MockCollectionRepository mockRepository;

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
    mockRepository = MockCollectionRepository();
    usecase = AddCollection(mockRepository);
  });

  final tCollection = Collection(
    id: '1',
    name: 'Test Collection',
    description: 'Test Description',
    color: 0xFF000000,
    createdAt: DateTime.now(),
  );

  test('debería agregar una colección al repositorio', () async {
    // Arrange
    when(() => mockRepository.addCollection(any()))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(tCollection);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.addCollection(tCollection)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('debería retornar un Failure cuando el repositorio falla', () async {
    // Arrange
    const tFailure = UnexpectedFailure('Error al agregar colección');
    when(() => mockRepository.addCollection(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await usecase(tCollection);

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.addCollection(tCollection)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
