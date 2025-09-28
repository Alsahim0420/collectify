import 'package:dartz/dartz.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/collection_repository.dart';

class DeleteCollection {
  const DeleteCollection(this._repository);
  final CollectionRepository _repository;

  Future<Either<Failure, void>> call(String id) async {
    return await _repository.deleteCollection(id);
  }
}
