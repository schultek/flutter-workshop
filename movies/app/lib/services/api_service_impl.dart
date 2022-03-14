import '../models/movie.dart';
import 'api_service.dart';

/// A local implementation of the ApiService that does not communicate with the
/// server.
class LocalApiServiceImpl implements ApiService {
  final Map<String, Movie> movies = {};

  @override
  Future<void> addMovie(Movie movie) async {
    movies[movie.id] = movie;
  }

  @override
  Future<List<Movie>> getAllMovies() async {
    return movies.values.toList();
  }

  @override
  Future<void> addRating(String movieId, MovieRating rating) async {
    movies[movieId]?.ratings.add(rating);
  }
}
