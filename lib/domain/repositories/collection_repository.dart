import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/types/either.dart';

abstract class CollectionRepository {
  Future<Either<Failure, List<Collection>>> getCollections();
  Future<Either<Failure, void>> addCollection(Collection collection);
  Future<Either<Failure, void>> deleteCollection(String id);
}
