import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_shared/models/movie.dart';

import '../services/movie_service.dart';
import 'popups/add_review_popup.dart';
import 'popups/show_ratings_popup.dart';

/// A single tile for the main page, showing a movie title, genre, average rating and a button to append a rating.
class MovieTile extends StatelessWidget {
  final Movie movie;
  final void Function() reloadPage;

  const MovieTile(this.movie, this.reloadPage, {Key? key}) : super(key: key);

  void _onAppendReview(BuildContext context) async {
    MovieRating? rating = await showDialog(
      context: context,
      builder: (BuildContext context) => AddReviewPopup(
        existingMovie: movie,
      ),
    );
    if (rating != null) {
      await MovieService.instance.addRating(movie.id, rating);
      reloadPage();
    }
  }

  void _showRatings(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => ShowRatingsPopup(
        movie,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _showRatings(context);
      },
      title: Text(movie.name),
      subtitle: Text(movie.genre),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingBarIndicator(
            itemSize: 30,
            rating: movie.ratings.map((m) => m.rating).reduce((a, b) => a + b) /
                movie.ratings.length,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add),
            color: Colors.blue,
            onPressed: () => _onAppendReview(context),
          ),
        ],
      ),
    );
  }
}
