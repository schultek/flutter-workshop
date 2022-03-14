import '../models/movie.dart';

/// The ApiService provides stubs that are necessary for interactions between frontend and backend.
abstract class ApiService {
  static late ApiService instance;

  Future<void> addMovie(Movie movie);
  Future<List<Movie>> getAllMovies();
  Future<void> addRating(String movieId, MovieRating rating);
}
