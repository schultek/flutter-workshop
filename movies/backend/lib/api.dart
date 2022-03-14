import 'dart:convert';

import 'package:movies_shared/models/movie.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'services/movie_service_impl.dart';

Handler get apiHandler {
  var movieService = MovieServiceImpl();

  var router = Router();

  router.get('/movies', (request) async {
    // call service
    var movies = await movieService.getAllMovies();

    // encode response
    var data = jsonEncode(movies.map((m) => m.toMap()).toList());
    return Response.ok(data);
  });

  router.post('/movies/add', (request) async {
    // parse request
    var body = jsonDecode(await request.readAsString());
    var movie = Movie.fromMap(body);

    // call service
    await movieService.addMovie(movie);

    // send response
    return Response.ok('OK');
  });

  router.post('/movies/<movieId>/rating', (request) async {
    // parse request
    var movieId = request.params['movieId']!;
    var body = jsonDecode(await request.readAsString());
    var rating = MovieRating.fromMap(body);

    // call service
    await movieService.addRating(movieId, rating);

    // send response
    return Response.ok('OK');
  });

  return router;
}
