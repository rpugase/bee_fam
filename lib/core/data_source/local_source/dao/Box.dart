class Box<T> {
  final Map<int, T> _storage = {};

  Future<T?> get(int key) async => _storage[key];

  Future<int> add(T entity) async {
    int key = _nextKey();
    _storage[key] = entity;
    return key;
  }

  Future<Iterable<int>> addAll(Iterable<T> entities) async {
    var keys = <int>[];
    for (var entity in entities) {
      keys.add(await add(entity));
    }
    return keys;
  }

  // Future<void> delete(T entity) async {
  //   final key = _storage.entries
  //       .firstWhere((e) => e.value == entity, orElse: () => MapEntry(-1, entity))
  //       .key;
  //   if (key != -1) _storage.remove(key);
  // }
  //
  // Future<void> deleteAll(Iterable<T> entities) async {
  //   for (var entity in entities) {
  //     delete(entity);
  //   }
  // }

  Future<void> delete(int key) async => _storage.remove(key);

  Future<void> deleteAll(Iterable<int> keys) async => keys.forEach(_storage.remove);

  Future<void> put(int key, T entity) async {
    _storage[key] = entity;
  }

  int _nextKey() => (_storage.keys.isEmpty ? 0 : _storage.keys.reduce((a, b) => a > b ? a : b) + 1);

  Map<int, T> get all => Map.unmodifiable(_storage);
}
