import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie.dart';
import 'api_service.dart';

/// The Http implementation of the ApiService.
/// This implementation uses a standard domain and sub-urls to get/send the data.
/// It parses the data with jsonDecode/jsonEncode "manually".
class HttpApiServiceImpl implements ApiService {
  var domain = "http://192.168.0.7:8080/";

  @override
  Future<void> addMovie(Movie movie) async {
    var url = Uri.parse(domain + 'movies/add');
    var body = jsonEncode(movie.toMap());

    await http.post(url, body: body);
  }

  @override
  Future<List<Movie>> getAllMovies() async {
    var url = Uri.parse(domain + 'movies');

    var response = await http.get(url);

    return (jsonDecode(response.body) as List)
        .map((o) => Movie.fromMap(o))
        .toList();
  }

  @override
  Future<void> addRating(String movieId, MovieRating rating) async {
    var url = Uri.parse(domain + "movies/$movieId/rating");
    var body = jsonEncode(rating.toMap());

    await http.post(url, body: body);
  }
}
