import 'package:flutter/material.dart';
import 'package:movies_app/popups/add_review_popup.dart';
import 'package:movies_app/services/api_service_impl.dart';

import 'models/movie.dart';
import 'popups/change_username_popup.dart';
import 'services/api_service.dart';
import 'widgets/movie_tile.dart';

void main() {
  ApiService.instance = HttpApiServiceImpl();
  runApp(const MoviesApp());
}

/// The main app widget.
class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoviesPage(),
    );
  }
}

/// The main page of the app, showing a list of movie tiles and a floating button to add a new movie.
class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  /// Add a new movie and an initial review, and reload the list of movies afterwards.
  void _addReview() async {
    Movie? movie = await AddReviewPopup.show(context);
    if (movie != null) {
      await ApiService.instance.addMovie(movie);
      await _loadMovies();
    }
  }

  /// Fetch the list of movies and reviews and show them.
  Future<void> _loadMovies() async {
    print("Loading movies");
    movies = await ApiService.instance.getAllMovies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              ChangeUsernamePopup.show(context);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadMovies,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: movies.isEmpty
              ? const [Center(child: Text("No movies :("))]
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
