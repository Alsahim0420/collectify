import 'package:dartz/dartz.dart';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/collection_repository.dart';

class AddCollection {
  const AddCollection(this._repository);
  final CollectionRepository _repository;

  Future<Either<Failure, void>> call(Collection collection) async {
    return await _repository.addCollection(collection);
  }
}
