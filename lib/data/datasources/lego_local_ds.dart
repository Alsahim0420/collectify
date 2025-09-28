import 'package:collectify/data/models/lego_set_model.dart';

abstract class LegoLocalDataSource {
  Future<List<LegoSetModel>> getAll();
  Future<LegoSetModel> insert(LegoSetModel model);
  Future<LegoSetModel> update(LegoSetModel model);
  Future<String> delete(String id);
  Future<List<LegoSetModel>> search(String query);
}

class InMemoryLegoLocalDataSource implements LegoLocalDataSource {
  final List<LegoSetModel> _db = [];

  @override
  Future<List<LegoSetModel>> getAll() async => List.unmodifiable(_db);

  @override
  Future<LegoSetModel> insert(LegoSetModel model) async {
    _db.add(model);
    return model;
  }

  @override
  Future<LegoSetModel> update(LegoSetModel model) async {
    final idx = _db.indexWhere((m) => m.id == model.id);
    if (idx == -1) throw StateError('not found');
    _db[idx] = model;
    return model;
  }

  @override
  Future<String> delete(String id) async {
    _db.removeWhere((m) => m.id == id);
    return id;
  }

  @override
  Future<List<LegoSetModel>> search(String q) async => _db
      .where(
        (m) =>
            m.name.toLowerCase().contains(q.toLowerCase()) ||
            m.theme.toLowerCase().contains(q.toLowerCase()) ||
            m.setNumber.toString().contains(q),
      )
      .toList(growable: false);
}
