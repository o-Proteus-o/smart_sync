import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_sync/src/adapters/local_adapter.dart';

class HiveAdapter implements LocalAdapter {
  final Map<String, Box> _boxes = {};

  @override
  Future<void> initialize() async {
    await Hive.initFlutter();
  }

  @override
  Future<dynamic> create(String collection, dynamic data) async {
    final box = await _getBox(collection);
    final id =
        data['id']?.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString();
    await box.put(id, data);
    return data;
  }

  @override
  Future<dynamic> read(String collection, String id) async {
    final box = await _getBox(collection);
    return box.get(id);
  }

  @override
  Future<List<dynamic>> readAll(String collection) async {
    final box = await _getBox(collection);
    return box.values.toList();
  }

  @override
  Future<dynamic> update(String collection, String id, dynamic data) async {
    final box = await _getBox(collection);
    await box.put(id, data);
    return data;
  }

  @override
  Future<void> delete(String collection, String id) async {
    final box = await _getBox(collection);
    await box.delete(id);
  }

  @override
  Future<void> clear(String collection) async {
    final box = await _getBox(collection);
    await box.clear();
  }

  Future<Box> _getBox(String collection) async {
    if (!_boxes.containsKey(collection)) {
      _boxes[collection] = await Hive.openBox(collection);
    }
    return _boxes[collection]!;
  }
}
