import 'package:movies_shared/models/movie.dart';

abstract class MovieService {
  static late MovieService instance;

  Future<void> addMovie(Movie movie);
  Future<List<Movie>> getAllMovies();
  Future<void> addRating(String movieId, MovieRating rating);
}
