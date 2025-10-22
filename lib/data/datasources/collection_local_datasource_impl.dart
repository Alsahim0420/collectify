import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:collectify/domain/entities/collection.dart';
import 'package:collectify/data/datasources/collection_local_datasource.dart';

class CollectionLocalDataSourceImpl implements CollectionLocalDataSource {
  const CollectionLocalDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;

  static const String _collectionsKey = 'collections';

  @override
  Future<List<Collection>> getCollections() async {
    final jsonString = _prefs.getString(_collectionsKey);
    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Collection.fromJson(json)).toList();
  }

  @override
  Future<void> addCollection(Collection collection) async {
    final jsonString = _prefs.getString(_collectionsKey);
    List<Collection> collections;

    if (jsonString == null) {
      collections = [];
    } else {
      final List<dynamic> jsonList = json.decode(jsonString);
      collections = jsonList.map((json) => Collection.fromJson(json)).toList();
    }

    collections.add(collection);
    await _saveCollections(collections);
  }

  @override
  Future<void> deleteCollection(String id) async {
    final jsonString = _prefs.getString(_collectionsKey);
    if (jsonString == null) return;

    final List<dynamic> jsonList = json.decode(jsonString);
    final collections = jsonList
        .map((json) => Collection.fromJson(json))
        .toList();

    collections.removeWhere((collection) => collection.id == id);
    await _saveCollections(collections);
  }

  Future<void> _saveCollections(List<Collection> collections) async {
    final jsonList = collections
        .map((collection) => collection.toJson())
        .toList();
    await _prefs.setString(_collectionsKey, json.encode(jsonList));
  }
}
