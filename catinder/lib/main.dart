import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swipe_stack/swipe_stack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: MyHomePage(title: 'Catinder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

  static _MyHomePageState of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  List images = [];
  List favorites = [];

  @override
  void initState() {
    super.initState();

    http.get(
      Uri.parse("https://api.thecatapi.com/v1/images/search?format=json&mime_types=jpg&limit=100"),
      headers: {"x-api-key": "0e9baaca-e7a5-435f-bcef-62505b79f53c"},
    ).then((result) {
      var catImages = jsonDecode(result.body);
      setState(() {
        images = catImages;
      });
    });
  }

  void favorite(int index) {
    setState(() {
      var image = images.removeAt(index);
      favorites.add(image);
    });
  }

  void skip(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pageIndex == 0
          ? CardStackPage(images)
          : FavoritesPage(favorites),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Cats",
            icon: Icon(Icons.style),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}

class CardStackPage extends StatelessWidget {
  final List images;
  CardStackPage(this.images);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 600,
            child: SwipeStack(
              children: images.map((image) {
                return SwiperItem(builder: (position, progress) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      image["url"],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                });
              }).toList(),
              onSwipe: (index, position) {
                if (position == SwiperPosition.Right) {
                  MyHomePage.of(context).favorite(index);
                } else if (position == SwiperPosition.Left) {
                  MyHomePage.of(context).skip(index);
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    MyHomePage.of(context).skip(images.length - 1);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  color: Colors.green,
                  icon: Icon(Icons.check),
                  onPressed: () {
                    MyHomePage.of(context).favorite(images.length - 1);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List favorites;
  FavoritesPage(this.favorites);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: favorites.map((i) {
          return Image.network(
            i["url"],
            fit: BoxFit.cover,
          );
        }).toList(),
      ),
    );
  }
}
