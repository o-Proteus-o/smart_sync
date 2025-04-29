abstract class LocalAdapter {
  Future<void> initialize();
  Future<dynamic> create(String collection, dynamic data);
  Future<dynamic> read(String collection, String id);
  Future<List<dynamic>> readAll(String collection);
  Future<dynamic> update(String collection, String id, dynamic data);
  Future<void> delete(String collection, String id);
  Future<void> clear(String collection);
}