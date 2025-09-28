abstract class CollectionSelectionEvent {}

class LoadCollections extends CollectionSelectionEvent {}

class AddCollectionEvent extends CollectionSelectionEvent {
  AddCollectionEvent({
    required this.name,
    required this.description,
    required this.color,
  });
  final String name;
  final String description;
  final int color;
}

class DeleteCollectionEvent extends CollectionSelectionEvent {
  DeleteCollectionEvent(this.id);
  final String id;
}
