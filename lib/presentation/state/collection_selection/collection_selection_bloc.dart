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
    emit(CollectionSelectionLoading());
    final res = await _getCollections();
    res.fold(
      (l) {
        emit(CollectionSelectionError(l.message));
      },
      (r) {
        emit(CollectionSelectionLoaded(collections: r));
      },
    );
  }

  Future<void> _onAdd(
    AddCollectionEvent e,
    Emitter<CollectionSelectionState> emit,
  ) async {
    final newCollection = Collection(
      id: _uuid.v4(),
      name: e.name,
      description: e.description,
      color: e.color,
      createdAt: DateTime.now(),
    );
    await _addCollection(newCollection);
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
