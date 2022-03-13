import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:movies_shared/models/movie.dart';
import 'package:uuid/uuid.dart';

var computerIP = "http://192.168.0.7:8080/";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movies = [];

  void _addReview() async {
    Movie? movie = await showDialog(
      context: context,
      builder: (BuildContext context) => const AddReviewPopup(),
    );
    if (movie != null) {
      var url = Uri.parse(computerIP + 'movie');
      await http.post(url, body: jsonEncode(movie.toMap()));
      await _loadMovies();
    }
  }

  Future<void> _loadMovies() async {
    print("Loading movies");
    var url = Uri.parse(computerIP + 'movies');
    movies = (jsonDecode((await http.get(url)).body) as List).map((o) => Movie.fromMap(o)).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: RefreshIndicator(
        onRefresh: _loadMovies,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: movies.isEmpty
              ? [
                  const Center(
                    child: Text("No movies:("),
                  ),
                ]
              : movies.map((m) => MovieTile(m, _loadMovies)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReview,
        tooltip: 'Add review',
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
      var url = Uri.parse(computerIP + "movies/${movie.id}/rating");
      await http.post(url, body: jsonEncode(rating.toMap()));
      reloadPage();
    }
    print("append review");
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movie.name),
      subtitle: Text(movie.genre),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO make rating bar unchangeable
          RatingBar.builder(
            itemSize: 30,
            allowHalfRating: true,
            initialRating: movie.ratings.map((m) => m.rating).reduce((a, b) => a + b) / movie.ratings.length,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (double value) {},
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

class AddReviewPopup extends StatefulWidget {
  final Movie? existingMovie;

  const AddReviewPopup({this.existingMovie, Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AddReviewPopupState();
}

class _AddReviewPopupState extends State<AddReviewPopup> {
  String? name, genre;
  int? rating;
  bool allFieldsFilled = false;

  void _checkAllFieldsFilled() {
    setState(() => allFieldsFilled = name != null && genre != null && rating != null);
  }

  @override
  void initState() {
    super.initState();
    name = widget.existingMovie?.name;
    genre = widget.existingMovie?.genre;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new movie review!'),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        widget.existingMovie == null
            ? TextField(
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
        widget.existingMovie == null
            ? TextField(
                onChanged: (val) {
                  genre = val.isEmpty ? null : val;
                  _checkAllFieldsFilled();
                },
              )
            : Text(
                genre!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
        RatingBar.builder(
          itemSize: 30,
          allowHalfRating: true,
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
      ]),
      actions: <Widget>[
        ElevatedButton(
          onPressed: allFieldsFilled
              ? () {
                  if (widget.existingMovie == null) {
                    Navigator.of(context).pop(Movie.fromMap({
                      "name": name,
                      "genre": genre,
                      "id": const Uuid().toString(),
                      "ratings": [
                        {"rating": rating, "author": "me"},
                      ]
                    }));
                  } else {
                    Navigator.of(context).pop(
                      MovieRating.fromMap(
                        {"rating": rating, "author": "me"},
                      ),
                    );
                  }
                }
              : null,
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
