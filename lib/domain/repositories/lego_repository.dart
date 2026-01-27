import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/types/either.dart';

abstract class LegoRepository {
  Future<Either<Failure, List<LegoSet>>> getSets();
  Future<Either<Failure, LegoSet>> addSet(LegoSet set);
  Future<Either<Failure, LegoSet>> updateSet(LegoSet set);
  Future<Either<Failure, String>> deleteSet(String id);
  Future<Either<Failure, List<LegoSet>>> search(String query);
}
