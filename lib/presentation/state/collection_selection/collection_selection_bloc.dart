import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/usecases/get_collections.dart';
import 'package:collectify/domain/usecases/add_collection.dart';
import 'package:collectify/domain/usecases/delete_collection.dart';
import 'package:collectify/presentation/state/collection_selection/collection_selection_event.dart';
import 'package:collectify/presentation/state/collection_selection/collection_selection_state.dart';

class CollectionSelectionBloc
    extends Bloc<CollectionSelectionEvent, CollectionSelectionState> {
  CollectionSelectionBloc(
    this._getCollections,
    this._addCollection,
    this._deleteCollection,
  ) : super(CollectionSelectionInitial()) {
    on<LoadCollections>(_onLoad);
    on<AddCollectionEvent>(_onAdd);
    on<DeleteCollectionEvent>(_onDelete);
  }

  final GetCollections _getCollections;
  final AddCollection _addCollection;
  final DeleteCollection _deleteCollection;
  final _uuid = const Uuid();

  Future<void> _onLoad(
    LoadCollections e,
    Emitter<CollectionSelectionState> emit,
  ) async {
    print('🔄 Collection BLoC: Cargando colecciones...');
    emit(CollectionSelectionLoading());
    final res = await _getCollections();
    res.fold(
      (l) {
        print('❌ Collection BLoC: Error al cargar: ${l.message}');
        emit(CollectionSelectionError(l.message));
      },
      (r) {
        print(
          '✅ Collection BLoC: Cargadas ${r.length} colecciones exitosamente',
        );
        emit(CollectionSelectionLoaded(collections: r));
      },
    );
  }

  Future<void> _onAdd(
    AddCollectionEvent e,
    Emitter<CollectionSelectionState> emit,
  ) async {
    print('➕ Collection BLoC: Agregando nueva colección: ${e.name}');
    final newCollection = Collection(
      id: _uuid.v4(),
      name: e.name,
      description: e.description,
      color: e.color,
      createdAt: DateTime.now(),
    );
    print(
      '💾 Collection BLoC: Guardando colección con ID: ${newCollection.id}',
    );
    await _addCollection(newCollection);
    print('🔄 Collection BLoC: Recargando lista después de agregar');
    add(LoadCollections());
  }

  Future<void> _onDelete(
    DeleteCollectionEvent e,
    Emitter<CollectionSelectionState> emit,
  ) async {
    await _deleteCollection(e.id);
    add(LoadCollections());
  }
}
