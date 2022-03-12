class Movie {
  String name;
  String genre;

  List<MovieRating> ratings;

  Movie(this.name, this.genre, this.ratings);

  Movie.fromMap(Map<String, dynamic> map)
      : name = map['name']!,
        genre = map['genre'],
        ratings = map['ratings'].map(MovieRating.fromMap).toList();

  Map<String, dynamic> toMap() {
    return {
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
