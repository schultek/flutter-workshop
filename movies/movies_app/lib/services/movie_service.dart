import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_shared/models/movie.dart';

/// The main service that communicates with the backend via HTTP.
/// This implementation uses a standard domain and sub-urls to get/send the data.
/// It parses the data with jsonDecode/jsonEncode "manually".
class MovieService {
  static late MovieService instance = MovieService();
  var domain = "http://192.168.0.184:8080/";

  Future<List<Movie>> getAllMovies() async {
    // construct url
    var url = Uri.parse(domain + 'movies');
    // send request
    var response = await http.get(url);
    // decode response
    return (jsonDecode(response.body) as List)
        .map((o) => Movie.fromMap(o))
        .toList();
  }

  Future<void> addMovie(Movie movie) async {
    // construct url
    var url = Uri.parse(domain + 'movies/add');
    // encode data
    var body = jsonEncode(movie.toMap());
    // send request
    await http.post(url, body: body);
  }

  Future<void> addRating(String movieId, MovieRating rating) async {
    // construct url
    var url = Uri.parse(domain + "movies/$movieId/rating");
    // encode data
    var body = jsonEncode(rating.toMap());
    // send request
    await http.post(url, body: body);
  }
}
