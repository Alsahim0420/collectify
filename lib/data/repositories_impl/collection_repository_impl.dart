import 'package:dartz/dartz.dart';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/domain/failures/failures.dart';
import 'package:collectify/domain/repositories/collection_repository.dart';
import 'package:collectify/data/datasources/collection_local_datasource.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  const CollectionRepositoryImpl(this._localDataSource);
  final CollectionLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<Collection>>> getCollections() async {
    try {
      final collections = await _localDataSource.getCollections();
      return Right(collections);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addCollection(Collection collection) async {
    try {
      await _localDataSource.addCollection(collection);
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCollection(String id) async {
    try {
      await _localDataSource.deleteCollection(id);
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
