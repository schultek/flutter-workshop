import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:swipable_stack/swipable_stack.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:riverpod_context/riverpod_context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: InheritedConsumer(child: MyApp())));
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
      Uri.parse("https://api.thecatapi.com/v1/images/search?format=json&mime_types=jpg&limit=10"),
      headers: {"x-api-key": "0e9baaca-e7a5-435f-bcef-62505b79f53c"},
    ).then((result) {
      var catImages = jsonDecode(result.body);
      setState(() {
        images = catImages;
      });
    });

    FirebaseFirestore.instance.collection('favs').snapshots().listen((snapshot) {
      var favs = snapshot.docs.map((d) => d.data()).toList();
      setState(() {
        favorites = favs;
      });
    });
  }

  void favorite(int index) {
    var image = images[index];
    setState(() {
      favorites.add(image);
    });
    FirebaseFirestore.instance.collection('favs').add(image);
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

class CardStackPage extends StatefulWidget {
  final List images;
  CardStackPage(this.images);

  @override
  State<CardStackPage> createState() => _CardStackPageState();
}

class _CardStackPageState extends State<CardStackPage> {
  SwipableStackController controller = SwipableStackController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 600,
            padding: EdgeInsets.all(20),
            child: SwipableStack(
              controller: controller,
              itemCount: widget.images.length,
              stackClipBehaviour: Clip.none,
              builder: (context, props) {
                var image = widget.images[props.index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image["url"],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
              onSwipeCompleted: (index, direction) {
                if (direction == SwipeDirection.right) {
                  MyHomePage.of(context).favorite(index);
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
                    controller.next(swipeDirection: SwipeDirection.left);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  color: Colors.green,
                  icon: Icon(Icons.check),
                  onPressed: () {
                    controller.next(swipeDirection: SwipeDirection.right);
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
