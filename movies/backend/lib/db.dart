import 'package:movies_shared/models/movie.dart';

abstract class MovieDatabase {
  Future<List<Movie>> getMovies();

  Future<Movie?> getMovieById(String id);

  Future<void> addMovieRating(String id, MovieRating rating);

  Future<void> insertMovie(Movie movie);
}

class InMemoryMovieDatabase implements MovieDatabase {
  final movies = <String, Movie>{};

  @override
  Future<List<Movie>> getMovies() async {
    return movies.values.toList();
  }

  @override
  Future<Movie?> getMovieById(String id) async {
    return movies[id];
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    movies[movie.id] = movie;
  }

  @override
  Future<void> addMovieRating(String id, MovieRating rating) async {
    var movie = movies[id]!;
    movie.ratings.add(rating);
  }
}
