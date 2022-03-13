import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_shared/models/movie.dart';

class ShowRatingsPopup extends StatelessWidget {
  final Movie movie;

  const ShowRatingsPopup(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Text(
          'Movie Ratings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      children: [
        ...movie.ratings.map(
          (r) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(r.author),
              RatingBarIndicator(
                itemSize: 30,
                rating: r.rating * 1.0,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ],
    );
  }
}
