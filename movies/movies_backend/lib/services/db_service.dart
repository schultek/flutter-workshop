import 'package:movies_shared/models/movie.dart';

abstract class DatabaseService<T> {
  Future<List<T>> queryAll();

  Future<T?> queryById(String id);

  Future<void> insert(T entity);

  Future<void> update(T entity);
}

class InMemoryMovieDatabase implements DatabaseService<Movie> {
  final movies = <String, Movie>{
    'hobbit': Movie('hobbit', 'The Hobbit 1', 'Fantasy', [
      MovieRating(5, 'Anja'),
      MovieRating(2, 'Steffen'),
    ]),
    'redsparrow': Movie('redsparrow', 'Red Sparrow', 'Thriller', [
      MovieRating(3, 'Viviana'),
    ]),
  };

  @override
  Future<List<Movie>> queryAll() async {
    return movies.values.toList();
  }

  @override
  Future<Movie?> queryById(String id) async {
    return movies[id];
  }

  @override
  Future<void> insert(Movie movie) async {
    movies[movie.id] = movie;
  }

  @override
  Future<void> update(Movie movie) async {
    movies[movie.id] = movie;
  }
}
