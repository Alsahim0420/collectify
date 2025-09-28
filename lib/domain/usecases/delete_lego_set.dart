import 'package:dartz/dartz.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';

class DeleteLegoSet {
  DeleteLegoSet(this.repo);
  final LegoRepository repo;

  Future<Either<Failure, String>> call(String id) => repo.deleteSet(id);
}
