import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collectify/data/datasources/lego_local_ds.dart';
import 'package:collectify/data/datasources/lego_hive_ds.dart';
import 'package:collectify/data/datasources/collection_local_datasource_impl.dart';
import 'package:collectify/data/datasources/collection_local_datasource.dart';
import 'package:collectify/data/repositories_impl/lego_repository_impl.dart';
import 'package:collectify/data/repositories_impl/collection_repository_impl.dart';
import 'package:collectify/domain/repositories/lego_repository.dart';
import 'package:collectify/domain/repositories/collection_repository.dart';
import 'package:collectify/domain/usecases/get_lego_sets.dart';
import 'package:collectify/domain/usecases/add_lego_set.dart';
import 'package:collectify/domain/usecases/update_lego_set.dart';
import 'package:collectify/domain/usecases/delete_lego_set.dart';
import 'package:collectify/domain/usecases/search_lego_sets.dart';
import 'package:collectify/domain/usecases/get_collections.dart';
import 'package:collectify/domain/usecases/add_collection.dart';
import 'package:collectify/domain/usecases/delete_collection.dart';

final sl = GetIt.instance;

Future<void> initInjector() async {
  //? External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //? Data sources
  final hiveDataSource = HiveLegoLocalDataSource();
  await hiveDataSource.init();

  sl.registerLazySingleton<LegoLocalDataSource>(() => hiveDataSource);
  sl.registerLazySingleton<CollectionLocalDataSource>(
    () => CollectionLocalDataSourceImpl(sl()),
  );

  //? Repositories
  sl.registerLazySingleton<LegoRepository>(() => LegoRepositoryImpl(sl()));
  sl.registerLazySingleton<CollectionRepository>(
    () => CollectionRepositoryImpl(sl()),
  );

  //? Use cases
  sl.registerLazySingleton(() => GetLegoSets(sl()));
  sl.registerLazySingleton(() => AddLegoSet(sl()));
  sl.registerLazySingleton(() => UpdateLegoSet(sl()));
  sl.registerLazySingleton(() => DeleteLegoSet(sl()));
  sl.registerLazySingleton(() => SearchLegoSets(sl()));
  sl.registerLazySingleton(() => GetCollections(sl()));
  sl.registerLazySingleton(() => AddCollection(sl()));
  sl.registerLazySingleton(() => DeleteCollection(sl()));
}
