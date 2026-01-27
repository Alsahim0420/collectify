import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/types/either.dart';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/usecases/get_collections.dart';
import 'package:collectify/domain/usecases/add_collection.dart';
import 'package:collectify/domain/usecases/delete_collection.dart';
import 'package:collectify/presentation/state/collection_selection/collection_selection_bloc.dart';
import 'package:collectify/presentation/state/collection_selection/collection_selection_event.dart';
import 'package:collectify/presentation/state/collection_selection/collection_selection_state.dart';

class MockGetCollections extends Mock implements GetCollections {}

class MockAddCollection extends Mock implements AddCollection {}

class MockDeleteCollection extends Mock implements DeleteCollection {}

void main() {
  late CollectionSelectionBloc bloc;
  late MockGetCollections mockGetCollections;
  late MockAddCollection mockAddCollection;
  late MockDeleteCollection mockDeleteCollection;

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
    mockGetCollections = MockGetCollections();
    mockAddCollection = MockAddCollection();
    mockDeleteCollection = MockDeleteCollection();
    bloc = CollectionSelectionBloc(
      mockGetCollections,
      mockAddCollection,
      mockDeleteCollection,
    );
  });

  tearDown(() {
    bloc.close();
  });

  final tCollections = [
    Collection(
      id: '1',
      name: 'Test Collection',
      description: 'Test Description',
      color: 0xFF000000,
      createdAt: DateTime.now(),
    ),
  ];

  test('estado inicial debería ser CollectionSelectionInitial', () {
    expect(bloc.state, isA<CollectionSelectionInitial>());
  });

  blocTest<CollectionSelectionBloc, CollectionSelectionState>(
    'debería emitir [CollectionSelectionLoading, CollectionSelectionLoaded] cuando LoadCollections es exitoso',
    build: () {
      when(() => mockGetCollections())
          .thenAnswer((_) async => Right(tCollections));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadCollections()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      isA<CollectionSelectionLoading>(),
      isA<CollectionSelectionLoaded>(),
    ],
    verify: (_) {
      final state = bloc.state as CollectionSelectionLoaded;
      expect(state.collections, tCollections);
      verify(() => mockGetCollections()).called(1);
    },
  );

  blocTest<CollectionSelectionBloc, CollectionSelectionState>(
    'debería emitir [CollectionSelectionLoading, CollectionSelectionError] cuando LoadCollections falla',
    build: () {
      const failure = UnexpectedFailure('Error');
      when(() => mockGetCollections())
          .thenAnswer((_) async => const Left(failure));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadCollections()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      isA<CollectionSelectionLoading>(),
      isA<CollectionSelectionError>(),
    ],
    verify: (_) {
      final state = bloc.state as CollectionSelectionError;
      expect(state.message, 'Error');
      verify(() => mockGetCollections()).called(1);
    },
  );

  blocTest<CollectionSelectionBloc, CollectionSelectionState>(
    'debería agregar una colección y recargar la lista',
    build: () {
      when(() => mockAddCollection(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockGetCollections())
          .thenAnswer((_) async => Right(tCollections));
      return bloc;
    },
    act: (bloc) => bloc.add(AddCollectionEvent(
      name: 'New Collection',
      description: 'New Description',
      color: 0xFFFFFFFF,
    )),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      isA<CollectionSelectionLoading>(),
      isA<CollectionSelectionLoaded>(),
    ],
    verify: (_) {
      verify(() => mockAddCollection(any())).called(1);
      verify(() => mockGetCollections()).called(1);
    },
  );

  blocTest<CollectionSelectionBloc, CollectionSelectionState>(
    'debería eliminar una colección y recargar la lista',
    build: () {
      when(() => mockDeleteCollection(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockGetCollections())
          .thenAnswer((_) async => Right(tCollections));
      return bloc;
    },
    act: (bloc) => bloc.add(DeleteCollectionEvent('1')),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      isA<CollectionSelectionLoading>(),
      isA<CollectionSelectionLoaded>(),
    ],
    verify: (_) {
      verify(() => mockDeleteCollection('1')).called(1);
      verify(() => mockGetCollections()).called(1);
    },
  );
}
