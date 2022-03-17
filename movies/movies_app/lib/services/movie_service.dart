import 'package:http/http.dart' as http;
import 'package:movies_shared/models/movie.dart';

/// The main service that communicates with the backend via HTTP.
/// It uses a standard domain and sub-urls to get/send the data.
class MovieService {
  static late MovieService instance = MovieService();
  var domain = "http://192.168.0.184:8080/";

  Future<List<Movie>> getAllMovies() async {
    // construct url
    var url = Uri.parse(domain + 'movies');
    // send request
    var response = await http.get(url);
    // decode response
    return Mapper.fromJson<List<Movie>>(response.body);
  }

  Future<void> addMovie(Movie movie) async {
    // construct url
    var url = Uri.parse(domain + 'movies/add');
    // send request
    await http.post(url, body: movie.toJson());
  }

  Future<void> addRating(String movieId, MovieRating rating) async {
    // construct url
    var url = Uri.parse(domain + "movies/$movieId/rating");
    // send request
    await http.post(url, body: rating.toJson());
  }
}
