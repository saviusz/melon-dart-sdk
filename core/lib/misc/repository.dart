abstract class Repository<T> {
  /** Adds item to storage */
  Future<void> save(T item);

  /** Returns list of items matching filter. If filter is null, returns all items */
  Future<List<T>> list(bool Function(T)? filter);

  /** Returns first item matching filter or null */
  Future<T?> get(bool Function(T) filter) async {
    try {
      return list(filter).then((items) => items.first);
    } catch (e) {
      return null;
    }
  }

  Future<bool> has(bool Function(T) filter) =>
      get(filter).then((item) => item != null);
}
