class Movie {
  String id;
  String name;
  String genre;

  List<MovieRating> ratings;

  Movie(this.id, this.name, this.genre, this.ratings);

  Movie.fromMap(Map<String, dynamic> map)
      : id = map['id']!,
        name = map['name']!,
        genre = map['genre'],
        ratings = (map['ratings'] as List)
            .map((m) => MovieRating.fromMap(m))
            .toList();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'genre': genre,
      'ratings': ratings.map((r) => r.toMap()).toList(),
    };
  }
}

class MovieRating {
  int rating;
  String author;

  MovieRating(this.rating, this.author);

  MovieRating.fromMap(Map<String, dynamic> map)
      : rating = map['rating'],
        author = map['author'];

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'author': author,
    };
  }
}
