import 'package:movies_backend/services/db_service.dart';
import 'package:movies_shared/models/movie.dart';

import 'db_service_impl.dart';
import 'movie_service.dart';

class MovieServiceImpl implements MovieService {
  final DatabaseService db = InMemoryMovieDatabase();

  @override
  Future<void> addMovie(Movie movie) async {
    await db.insertMovie(movie);
  }

  @override
  Future<List<Movie>> getAllMovies() {
    return db.getMovies();
  }

  @override
  Future<void> addRating(String movieId, MovieRating rating) async {
    var movie = await db.getMovieById(movieId);

    if (movie == null) {
      throw 'Movie with id $movieId does not exist.';
    }

    await db.addMovieRating(movieId, rating);
  }
}
