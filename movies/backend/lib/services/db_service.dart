import 'package:movies_shared/models/movie.dart';

abstract class DatabaseService {
  static late DatabaseService instance;

  Future<List<Movie>> getMovies();

  Future<Movie?> getMovieById(String id);

  Future<void> addMovieRating(String id, MovieRating rating);

  Future<void> insertMovie(Movie movie);
}
