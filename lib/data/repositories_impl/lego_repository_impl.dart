import 'package:dartz/dartz.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';
import 'package:collectify/data/datasources/lego_local_ds.dart';
import 'package:collectify/data/models/lego_set_model.dart';

class LegoRepositoryImpl implements LegoRepository {
  LegoRepositoryImpl(this.local);
  final LegoLocalDataSource local;

  @override
  Future<Either<Failure, List<LegoSet>>> getSets() async {
    try {
      final res = await local.getAll();
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, LegoSet>> addSet(LegoSet set) async {
    try {
      final saved = await local.insert(LegoSetModel.fromEntity(set));
      return Right(saved.toEntity());
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, LegoSet>> updateSet(LegoSet set) async {
    try {
      final saved = await local.update(LegoSetModel.fromEntity(set));
      return Right(saved.toEntity());
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteSet(String id) async {
    try {
      final deletedId = await local.delete(id);
      return Right(deletedId);
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<LegoSet>>> search(String query) async {
    try {
      final res = await local.search(query);
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }
}
