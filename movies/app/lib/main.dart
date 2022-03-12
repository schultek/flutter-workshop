import 'package:flutter/material.dart';
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
  void _addReview() {
    print("add review");
  }

  List<Movie> movies = [
    Movie("Fast and Furious", "Drama", []),
    Movie("Fast and Furious 2", "Drama", []),
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
      trailing: IconButton(
        icon: const Icon(Icons.add),
        color: Colors.blue,
        onPressed: _onAppendReview,
      ),
    );
  }
}
