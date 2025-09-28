import 'package:collectify/domain/entities/collection.dart';

abstract class CollectionSelectionState {}

class CollectionSelectionInitial extends CollectionSelectionState {}

class CollectionSelectionLoading extends CollectionSelectionState {}

class CollectionSelectionLoaded extends CollectionSelectionState {
  CollectionSelectionLoaded({required this.collections});
  final List<Collection> collections;
}

class CollectionSelectionError extends CollectionSelectionState {
  CollectionSelectionError(this.message);
  final String message;
}
