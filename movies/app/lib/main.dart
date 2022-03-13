import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/popups/AddReviewPopup.dart';
import 'package:movies_app/popups/ShowRatingsPopup.dart';
import 'package:movies_shared/models/movie.dart';

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
      var url = Uri.parse(computerIP + 'movies/add');
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

  void _showRatings(BuildContext context) async {
    print("show ratings");
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
