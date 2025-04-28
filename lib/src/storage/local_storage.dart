// local_storage.dart
import 'package:hive/hive.dart';

abstract class LocalStorage<T> {
  Future<T?> read();
  Future<void> save(T value);
}

// Concrete implementation of LocalStorage for storing int values
class HiveStorage<T> extends LocalStorage<T> {
  final String boxName;
  final String key;

  HiveStorage({required this.boxName, required this.key});

  @override
  Future<T?> read() async {
    // Replace this with the actual logic to read from Hive database
    // Example:
    var box = await Hive.openBox<T>(boxName);
    return box.get(key);
  }

  @override
  Future<void> save(T value) async {
    // Replace this with the actual logic to save to Hive database
    var box = await Hive.openBox<T>(boxName);
    await box.put(key, value);
  }
}
