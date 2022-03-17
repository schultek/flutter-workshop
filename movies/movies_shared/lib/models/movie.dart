import 'package:dart_mappable/dart_mappable.dart';

import 'movie.mapper.g.dart';

export 'movie.mapper.g.dart';

@MappableClass()
class Movie with Mappable {
  final String id;
  final String name;
  final String genre;

  final List<MovieRating> ratings;

  Movie(this.id, this.name, this.genre, this.ratings);
}

@MappableClass()
class MovieRating with Mappable {
  final int rating;
  final String author;

  MovieRating(this.rating, this.author);
}
