import 'package:dartz/dartz.dart';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/collection_repository.dart';

class GetCollections {
  const GetCollections(this._repository);
  final CollectionRepository _repository;

  Future<Either<Failure, List<Collection>>> call() async {
    return await _repository.getCollections();
  }
}
