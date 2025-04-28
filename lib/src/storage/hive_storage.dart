import 'package:hive_flutter/hive_flutter.dart';
import 'local_storage.dart';

class HiveStorage<T> implements LocalStorage<T> {
  final String boxName;
  final String key;

  HiveStorage({required this.boxName, required this.key});

  @override
  Future<void> save(T state) async {
    final box = await Hive.openBox<T>(boxName);
    await box.put(key, state);
  }

  @override
  Future<T?> read() async {
    final box = await Hive.openBox<T>(boxName);
    return box.get(key);
  }
}
