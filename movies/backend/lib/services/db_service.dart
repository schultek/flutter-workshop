abstract class DatabaseService<T> {
  Future<List<T>> queryAll();

  Future<T?> queryById(String id);

  Future<void> insert(T entity);

  Future<void> update(T entity);
}
