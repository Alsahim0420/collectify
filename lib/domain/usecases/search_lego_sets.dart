import 'package:dartz/dartz.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';

class SearchLegoSets {
  SearchLegoSets(this.repo);
  final LegoRepository repo;

  Future<Either<Failure, List<LegoSet>>> call(String query) =>
      repo.search(query);
}
