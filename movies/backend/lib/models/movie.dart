class Movie {
  String id;
  String name;
  String genre;

  List<MovieRating> ratings;

  Movie(this.id, this.name, this.genre, this.ratings);
}

class MovieRating {
  int rating;
  String author;

  MovieRating(this.rating, this.author);
}
