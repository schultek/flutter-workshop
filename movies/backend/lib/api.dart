import 'dart:convert';

import 'package:movies_shared/models/movie.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'db.dart';

final MovieDatabase db = InMemoryMovieDatabase();

Handler get apiHandler => Router()
  ..get('/movies', moviesHandler)
  ..post('/movies/add', addMovieHandler)
  ..post('/movies/<movieId>/rating', addRatingToMovieHandler);

Future<Response> moviesHandler(Request request) async {
  var movies = await db.getMovies();
  return Response.ok(jsonEncode(movies.map((m) => m.toMap()).toList()));
}

Future<Response> addMovieHandler(Request request) async {
  var map = jsonDecode(await request.readAsString());
  var movie = Movie.fromMap(map);

  await db.insertMovie(movie);

  return Response.ok('OK');
}

Future<Response> addRatingToMovieHandler(Request request) async {
  var movieId = request.params['movieId']!;

  var movie = await db.getMovieById(movieId);

  if (movie == null) {
    return Response(400, body: 'Movie with id $movieId does not exist.');
  }

  var rating = MovieRating.fromMap(jsonDecode(await request.readAsString()));
  await db.addMovieRating(movieId, rating);

  return Response.ok('OK');
}
