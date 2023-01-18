import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:http/http.dart';

import 'main.dart';

class CatsPage extends StatefulWidget {
  const CatsPage({Key? key}) : super(key: key);

  @override
  State<CatsPage> createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage> {
  List images = [];

  @override
  void initState() {
    super.initState();

    // https://pastebin.com/puk1ExiL
    // fetch data

    get(
      Uri.parse(
          "https://api.thecatapi.com/v1/images/search?format=json&mime_types=jpg&limit=100"),
      headers: {"x-api-key": "0e9baaca-e7a5-435f-bcef-62505b79f53c"},
    ).then((result) {
      List<dynamic> catImages = jsonDecode(result.body);
      setState(() {
        images = catImages;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SwipableStack(
        controller: SwipableStackController(),
        itemCount: images.length,
        stackClipBehaviour: Clip.none,
        onSwipeCompleted: (index, direction) {
          if (direction == SwipeDirection.right) {
            var homePage = context.findAncestorStateOfType<MyHomePageState>();
            homePage!.addFavorite(images[index]);
          }
        },
        builder: (context, props) {
          var index = props.index;
          var image = images[index];

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
      ),
    );
  }
}
