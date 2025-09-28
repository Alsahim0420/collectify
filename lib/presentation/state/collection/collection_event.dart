sealed class CollectionEvent {}

class LoadItems extends CollectionEvent {}

class AddItemEvent extends CollectionEvent {
  AddItemEvent(
    this.name,
    this.setNumber,
    this.theme,
    this.pieces,
    this.notes,
    this.collectionId,
  );
  final String name;
  final int setNumber;
  final String theme;
  final int pieces;
  final String notes;
  final String collectionId;
}

class UpdateItemEvent extends CollectionEvent {
  UpdateItemEvent(
    this.id,
    this.name,
    this.setNumber,
    this.theme,
    this.pieces,
    this.notes,
    this.collectionId,
  );
  final String id;
  final String name;
  final int setNumber;
  final String theme;
  final int pieces;
  final String notes;
  final String collectionId;
}

class DeleteItemEvent extends CollectionEvent {
  DeleteItemEvent(this.id);
  final String id;
}
