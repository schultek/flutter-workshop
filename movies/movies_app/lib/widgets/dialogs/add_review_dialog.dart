import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_shared/models/movie.dart';
import 'package:uuid/uuid.dart';

import '../../services/user_service.dart';

/// The popup that is shown when the user wants to add a review (to an existing movie or a new one).
class AddReviewDialog extends StatefulWidget {
  /// The movie where the review is appended, if it exists.
  /// If this value is empty, the popup will show fields for entering a title and genre.
  final Movie? existingMovie;

  const AddReviewDialog({this.existingMovie, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddReviewDialogState();

  static Future<Movie?> show(BuildContext context) {
    return showDialog<Movie>(
      context: context,
      builder: (context) => const AddReviewDialog(),
    );
  }
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  String? name, genre;
  int? rating;
  bool allFieldsFilled = false;

  void _checkAllFieldsFilled() {
    setState(() =>
        allFieldsFilled = name != null && genre != null && rating != null);
  }

  @override
  void initState() {
    super.initState();
    name = widget.existingMovie?.name;
    genre = widget.existingMovie?.genre;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: const Text(
          'Add a new movie review!',
          style: TextStyle(color: Colors.white),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      children: [
        widget.existingMovie == null
            ? TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                onChanged: (val) {
                  name = val.isEmpty ? null : val;
                  _checkAllFieldsFilled();
                },
              )
            : Text(
                name!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: widget.existingMovie == null
              ? TextField(
                  onChanged: (val) {
                    genre = val.isEmpty ? null : val;
                    _checkAllFieldsFilled();
                  },
                  decoration: InputDecoration(
                    hintText: "Genre",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                )
              : Text(
                  genre!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Rating"),
              RatingBar.builder(
                itemSize: 30,
                allowHalfRating: false,
                initialRating: 0,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) {
                  rating = value.round();
                  _checkAllFieldsFilled();
                },
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
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: allFieldsFilled
                  ? () {
                      if (widget.existingMovie == null) {
                        Navigator.of(context).pop(
                          Movie(const Uuid().v4(), name!, genre!, [
                            MovieRating(rating!, AuthService.instance.username)
                          ]),
                        );
                      } else {
                        Navigator.of(context).pop(
                          MovieRating(rating!, AuthService.instance.username),
                        );
                      }
                    }
                  : null,
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }
}
