import 'package:collectify/domain/entities/lego_set.dart';

sealed class CollectionState {
  const CollectionState();
}

class CollectionInitial extends CollectionState {
  const CollectionInitial();
}

class CollectionLoading extends CollectionState {
  const CollectionLoading();
}

class CollectionLoaded extends CollectionState {
  const CollectionLoaded(this.items);
  final List<LegoSet> items;
}

class CollectionError extends CollectionState {
  const CollectionError(this.message);
  final String message;
}
