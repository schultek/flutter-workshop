import '../models/movie.dart';
import 'db_service.dart';

class InMemoryMovieDatabase implements DatabaseService<Movie> {
  final movies = <String, Movie>{};

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
