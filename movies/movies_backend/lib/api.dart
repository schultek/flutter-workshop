import 'package:movies_backend/auth.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'movies.dart';
import 'services/movie_service.dart';

var movieService = MovieService();

Handler get apiHandler {
  var movies = moviesHandler;
  var auth = authHandler;

  var router = Router();

  router.mount('/movies', _guard(movies));
  router.mount('/auth', auth);

  return router;
}

Handler _guard(Handler handler) {
  return (request) {
    var token = request.headers['Authorization'];
    if (token != null) {
      if (userService.validateJWT(token)) {
        return handler(request);
      } else {
        return Response.forbidden('Invalid auth token.');
      }
    } else {
      return Response.forbidden('Missing auth token.');
    }
  };
}
