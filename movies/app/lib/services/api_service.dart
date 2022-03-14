import 'package:movies_shared/models/movie.dart';

abstract class ApiService {
  static late ApiService instance;

  Future<void> addMovie(Movie movie);
  Future<List<Movie>> getAllMovies();
  Future<void> addRating(String movieId, MovieRating rating);
}
