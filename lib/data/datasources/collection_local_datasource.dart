import 'package:collectify/domain/entities/collection.dart';

abstract class CollectionLocalDataSource {
  Future<List<Collection>> getCollections();
  Future<void> addCollection(Collection collection);
  Future<void> deleteCollection(String id);
}
