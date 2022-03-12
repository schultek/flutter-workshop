import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:movies_shared/models/movie.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addReview() async {
    Movie movie = Movie("test1", "thriller", [MovieRating(3, "me")]);
    var url = Uri.parse('http://localhost:8080/movie');
    var response = await http.post(url, body: jsonEncode(movie.toMap()));
    print("add review");
  }

  List<Movie> movies = [
    Movie("Fast and Furious", "Drama", [MovieRating(4, "x"), MovieRating(2, "x")]),
    Movie("Fast and Furious 2", "Drama", [MovieRating(0, "x"), MovieRating(5, "x")]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: ListView(
        children: movies.map((m) => MovieTile(m)).toList(),
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

  MovieTile(this.movie, {Key? key}) : super(key: key);

  void _onAppendReview() {
    print("append review");
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(movie.name),
        subtitle: Text(movie.genre),
        trailing: RatingBar.builder(
          allowHalfRating: true,
          initialRating: movie.ratings.map((m) => m.rating).reduce((a, b) => a + b) / movie.ratings.length,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (double value) {},
        )
        /*    IconButton(
        icon: const Icon(Icons.add),
        color: Colors.blue,
        onPressed: _onAppendReview,
      ),*/
        );
  }
}
