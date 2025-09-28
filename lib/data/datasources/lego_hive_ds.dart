import 'package:hive_flutter/hive_flutter.dart';
import 'package:collectify/data/models/lego_set_model.dart';
import 'package:collectify/data/datasources/lego_local_ds.dart';
import 'package:collectify/data/adapters/lego_set_adapter.dart';

class HiveLegoLocalDataSource implements LegoLocalDataSource {
  static const String _boxName = 'lego_sets_box';
  late Box<LegoSetModel> _box;

  Future<void> init() async {
    await Hive.initFlutter();

    //? Registrar el adaptador personalizado
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LegoSetAdapter());
    }

    _box = await Hive.openBox<LegoSetModel>(_boxName);
  }

  @override
  Future<List<LegoSetModel>> getAll() async {
    final items = _box.values.toList();
    return items;
  }

  @override
  Future<LegoSetModel> insert(LegoSetModel legoSet) async {
    await _box.put(legoSet.id, legoSet);
    return legoSet;
  }

  @override
  Future<LegoSetModel> update(LegoSetModel legoSet) async {
    await _box.put(legoSet.id, legoSet);
    return legoSet;
  }

  @override
  Future<String> delete(String id) async {
    await _box.delete(id);
    return id;
  }

  @override
  Future<List<LegoSetModel>> search(String query) async {
    final allSets = _box.values.toList();
    final lowercaseQuery = query.toLowerCase();

    return allSets.where((set) {
      return set.name.toLowerCase().contains(lowercaseQuery) ||
          set.theme.toLowerCase().contains(lowercaseQuery) ||
          set.setNumber.toString().contains(lowercaseQuery);
    }).toList();
  }

  Future<void> close() async {
    await _box.close();
  }
}
