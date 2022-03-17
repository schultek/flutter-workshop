import 'package:flutter/material.dart';
import 'package:movies_app/services/user_service.dart';
import 'package:movies_shared/models/movie.dart';

import '../services/movie_service.dart';
import '../widgets/dialogs/add_review_dialog.dart';
import '../widgets/movie_tile.dart';
import 'login_page.dart';

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
    Movie? movie = await AddReviewDialog.show(context);
    if (movie != null) {
      await MovieService.instance.addMovie(movie);
      await _loadMovies();
    }
  }

  /// Fetch the list of movies and reviews and show them.
  Future<void> _loadMovies() async {
    movies = await MovieService.instance.getAllMovies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthService.instance.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginPage()));
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
