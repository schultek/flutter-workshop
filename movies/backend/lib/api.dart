import 'dart:convert';

import 'package:movies_shared/models/movie.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Handler get apiHandler => Router()
  ..get('/', rootHandler)
  ..get('/echo/<message>', echoHandler)
  ..get('/movies', moviesHandler)
  ..post('/movie', addMovieHandler);

Response rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

final movies = <Movie>[];

Response moviesHandler(Request request) {
  return Response.ok(jsonEncode(movies.map((m) => m.toMap()).toList()));
}

Future<Response> addMovieHandler(Request request) async {
  var map = jsonDecode(await request.readAsString());
  movies.add(Movie.fromMap(map));

  return Response.ok('OK');
}
