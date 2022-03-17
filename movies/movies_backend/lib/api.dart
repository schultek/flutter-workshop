import 'package:movies_shared/models/movie.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'services/movie_service.dart';

var movieService = MovieService();

Handler get apiHandler {
  var router = Router();

  router.get('/movies', (Request request) async {
    // call service
    var movies = await movieService.getAllMovies();

    // send response
    return Response.ok(Mapper.toJson(movies));
  });

  router.post('/movies/add', (Request request) async {
    // parse request
    var movie = Mapper.fromJson<Movie>(await request.readAsString());

    // call service
    await movieService.addMovie(movie);

    // send response
    return Response.ok('OK');
  });

  router.post('/movies/<movieId>/rating', (Request request) async {
    // parse request
    var movieId = request.params['movieId']!;
    var rating = Mapper.fromJson<MovieRating>(await request.readAsString());

    // call service
    await movieService.addRating(movieId, rating);

    // send response
    return Response.ok('OK');
  });

  return router;
}
