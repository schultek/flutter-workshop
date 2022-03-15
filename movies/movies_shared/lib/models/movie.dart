class Movie {
  final String id;
  final String name;
  final String genre;

  final List<MovieRating> ratings;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          genre == other.genre &&
          ratings == other.ratings;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ genre.hashCode ^ ratings.hashCode;

  @override
  String toString() {
    return 'Movie{id: $id, name: $name, genre: $genre, ratings: $ratings}';
  }
}

class MovieRating {
  final int rating;
  final String author;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieRating &&
          runtimeType == other.runtimeType &&
          rating == other.rating &&
          author == other.author;

  @override
  int get hashCode => rating.hashCode ^ author.hashCode;

  @override
  String toString() {
    return 'MovieRating{rating: $rating, author: $author}';
  }
}
