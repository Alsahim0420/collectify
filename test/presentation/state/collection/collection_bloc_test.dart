import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:collectify/domain/types/either.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/usecases/get_lego_sets.dart';
import 'package:collectify/domain/usecases/add_lego_set.dart';
import 'package:collectify/domain/usecases/update_lego_set.dart';
import 'package:collectify/domain/usecases/delete_lego_set.dart';
import 'package:collectify/presentation/state/collection/collection_bloc.dart';
import 'package:collectify/presentation/state/collection/collection_event.dart';
import 'package:collectify/presentation/state/collection/collection_state.dart';

class MockGetLegoSets extends Mock implements GetLegoSets {}

class MockAddLegoSet extends Mock implements AddLegoSet {}

class MockUpdateLegoSet extends Mock implements UpdateLegoSet {}

class MockDeleteLegoSet extends Mock implements DeleteLegoSet {}

void main() {
  late CollectionBloc bloc;
  late MockGetLegoSets mockGetLegoSets;
  late MockAddLegoSet mockAddLegoSet;
  late MockUpdateLegoSet mockUpdateLegoSet;
  late MockDeleteLegoSet mockDeleteLegoSet;

  setUpAll(() {
    registerFallbackValue(LegoSet(
      id: '',
      name: '',
      setNumber: 0,
      theme: '',
      pieces: 0,
      notes: '',
      acquiredAt: DateTime.now(),
      collectionId: '',
    ));
  });

  setUp(() {
    mockGetLegoSets = MockGetLegoSets();
    mockAddLegoSet = MockAddLegoSet();
    mockUpdateLegoSet = MockUpdateLegoSet();
    mockDeleteLegoSet = MockDeleteLegoSet();
    bloc = CollectionBloc(
      mockGetLegoSets,
      mockAddLegoSet,
      mockUpdateLegoSet,
      mockDeleteLegoSet,
    );
  });

  tearDown(() {
    bloc.close();
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
  ];

  test('estado inicial debería ser CollectionInitial', () {
    expect(bloc.state, const CollectionInitial());
  });

  blocTest<CollectionBloc, CollectionState>(
    'debería emitir [CollectionLoading, CollectionLoaded] cuando LoadItems es exitoso',
    build: () {
      when(() => mockGetLegoSets())
          .thenAnswer((_) async => Right(tLegoSets));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadItems()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const CollectionLoading(),
      isA<CollectionLoaded>(),
    ],
    verify: (_) {
      final state = bloc.state as CollectionLoaded;
      expect(state.items, tLegoSets);
      verify(() => mockGetLegoSets()).called(1);
    },
  );

  blocTest<CollectionBloc, CollectionState>(
    'debería emitir [CollectionLoading, CollectionError] cuando LoadItems falla',
    build: () {
      const failure = UnexpectedFailure('Error');
      when(() => mockGetLegoSets())
          .thenAnswer((_) async => const Left(failure));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadItems()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const CollectionLoading(),
      isA<CollectionError>(),
    ],
    verify: (_) {
      final state = bloc.state as CollectionError;
      expect(state.message, 'Error');
      verify(() => mockGetLegoSets()).called(1);
    },
  );

  blocTest<CollectionBloc, CollectionState>(
    'debería agregar un item y recargar la lista',
    build: () {
      when(() => mockAddLegoSet(any()))
          .thenAnswer((_) async => Right(tLegoSets.first));
      when(() => mockGetLegoSets())
          .thenAnswer((_) async => Right(tLegoSets));
      return bloc;
    },
    act: (bloc) => bloc.add(AddItemEvent(
      'New Set',
      99999,
      'Theme',
      100,
      'Notes',
      'collection1',
    )),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      const CollectionLoading(),
      isA<CollectionLoaded>(),
    ],
    verify: (_) {
      final state = bloc.state as CollectionLoaded;
      expect(state.items, tLegoSets);
      verify(() => mockAddLegoSet(any())).called(1);
      verify(() => mockGetLegoSets()).called(1);
    },
  );

  blocTest<CollectionBloc, CollectionState>(
    'debería actualizar un item y recargar la lista',
    build: () {
      when(() => mockUpdateLegoSet(any()))
          .thenAnswer((_) async => Right(tLegoSets.first));
      when(() => mockGetLegoSets())
          .thenAnswer((_) async => Right(tLegoSets));
      return bloc;
    },
    seed: () => CollectionLoaded(tLegoSets),
    act: (bloc) => bloc.add(UpdateItemEvent(
      '1',
      'Updated Set',
      12345,
      'City',
      600,
      'Updated notes',
      'collection1',
    )),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      const CollectionLoading(),
      isA<CollectionLoaded>(),
    ],
    verify: (_) {
      final state = bloc.state as CollectionLoaded;
      expect(state.items, tLegoSets);
      verify(() => mockUpdateLegoSet(any())).called(1);
      verify(() => mockGetLegoSets()).called(1);
    },
  );

  blocTest<CollectionBloc, CollectionState>(
    'no debería actualizar si el estado no es CollectionLoaded',
    build: () {
      when(() => mockUpdateLegoSet(any()))
          .thenAnswer((_) async => Right(tLegoSets.first));
      return bloc;
    },
    seed: () => const CollectionInitial(),
    act: (bloc) => bloc.add(UpdateItemEvent(
      '1',
      'Updated Set',
      12345,
      'City',
      600,
      'Updated notes',
      'collection1',
    )),
    wait: const Duration(milliseconds: 100),
    expect: () => [],
    verify: (_) {
      verifyNever(() => mockUpdateLegoSet(any()));
    },
  );

  blocTest<CollectionBloc, CollectionState>(
    'debería eliminar un item y recargar la lista',
    build: () {
      when(() => mockDeleteLegoSet(any()))
          .thenAnswer((_) async => const Right('1'));
      when(() => mockGetLegoSets())
          .thenAnswer((_) async => Right(tLegoSets));
      return bloc;
    },
    act: (bloc) => bloc.add(DeleteItemEvent('1')),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      const CollectionLoading(),
      isA<CollectionLoaded>(),
    ],
    verify: (_) {
      final state = bloc.state as CollectionLoaded;
      expect(state.items, tLegoSets);
      verify(() => mockDeleteLegoSet('1')).called(1);
      verify(() => mockGetLegoSets()).called(1);
    },
  );
}
