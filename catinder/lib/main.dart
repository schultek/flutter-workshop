import 'package:flutter/material.dart';

import 'cats_page.dart';
import 'favorite_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'HI Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;
  List favorites = [];

  void addFavorite(dynamic catImage) {
    setState(() {
      favorites.add(catImage);
    });
  }

  void removeFavorite(dynamic catImage) {
    setState(() {
      favorites.remove(catImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: pageIndex != 0,
            child: const CatsPage(),
          ),
          Offstage(
            offstage: pageIndex != 1,
            child: FavoritePage(favorites),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: const [
          // cards
          BottomNavigationBarItem(
            label: "Cats",
            icon: Icon(Icons.style),
          ),
          // favorites
          BottomNavigationBarItem(
            label: "Favorite",
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
