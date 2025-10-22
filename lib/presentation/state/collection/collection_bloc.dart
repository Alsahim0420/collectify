import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/usecases/get_lego_sets.dart';
import 'package:collectify/domain/usecases/add_lego_set.dart';
import 'package:collectify/domain/usecases/update_lego_set.dart';
import 'package:collectify/domain/usecases/delete_lego_set.dart';
import 'package:collectify/presentation/state/collection/collection_event.dart';
import 'package:collectify/presentation/state/collection/collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc(
    this._getLegoSets,
    this._addLegoSet,
    this._updateLegoSet,
    this._deleteLegoSet,
  ) : super(const CollectionInitial()) {
    on<LoadItems>(_onLoad);
    on<AddItemEvent>(_onAdd);
    on<UpdateItemEvent>(_onUpdate);
    on<DeleteItemEvent>(_onDelete);
  }
  final GetLegoSets _getLegoSets;
  final AddLegoSet _addLegoSet;
  final UpdateLegoSet _updateLegoSet;
  final DeleteLegoSet _deleteLegoSet;
  final _uuid = const Uuid();

  Future<void> _onLoad(LoadItems e, Emitter<CollectionState> emit) async {
    emit(const CollectionLoading());
    final res = await _getLegoSets();
    res.fold(
      (l) {
        emit(CollectionError(l.message));
      },
      (r) {
        emit(CollectionLoaded(r));
      },
    );
  }

  Future<void> _onAdd(AddItemEvent e, Emitter<CollectionState> emit) async {
    final newSet = LegoSet(
      id: _uuid.v4(),
      name: e.name,
      setNumber: e.setNumber,
      theme: e.theme,
      pieces: e.pieces,
      notes: e.notes,
      acquiredAt: DateTime.now(),
      collectionId: e.collectionId,
    );
    await _addLegoSet(newSet);
    add(LoadItems());
  }

  Future<void> _onUpdate(
    UpdateItemEvent e,
    Emitter<CollectionState> emit,
  ) async {
    if (state is! CollectionLoaded) return;
    final current = (state as CollectionLoaded).items;
    final set = current
        .firstWhere((s) => s.id == e.id)
        .copyWith(
          name: e.name,
          setNumber: e.setNumber,
          theme: e.theme,
          pieces: e.pieces,
          notes: e.notes,
          collectionId: e.collectionId,
        );
    await _updateLegoSet(set);
    add(LoadItems());
  }

  Future<void> _onDelete(
    DeleteItemEvent e,
    Emitter<CollectionState> emit,
  ) async {
    await _deleteLegoSet(e.id);
    add(LoadItems());
  }
}
