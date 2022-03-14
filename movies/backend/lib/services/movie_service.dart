import 'package:movies_backend/services/db_service.dart';

import '../models/movie.dart';
import 'db_service_impl.dart';

class MovieService {
  final DatabaseService<Movie> db = InMemoryMovieDatabase();

  Future<List<Movie>> getAllMovies() {
    return db.queryAll();
  }

  Future<void> addMovie(Movie movie) async {
    await db.insert(movie);
  }

  Future<void> addRating(String movieId, MovieRating rating) async {
    var movie = await db.queryById(movieId);

    if (movie == null) {
      throw 'Movie with id $movieId does not exist.';
    }

    movie.ratings.add(rating);

    await db.update(movie);
  }
}
