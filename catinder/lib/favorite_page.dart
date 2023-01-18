import 'package:catinder/main.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage(this.favorites, {Key? key}) : super(key: key);

  final List favorites;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var favorite in favorites.reversed)
          Stack(children: [
            Image.network(
              favorite["url"],
              fit: BoxFit.cover,
            ),
            IconButton(
              onPressed: () {
                var state = context.findAncestorStateOfType<MyHomePageState>();
                state!.removeFavorite(favorite);
              },
              color: Colors.white,
              icon: const Icon(Icons.heart_broken),
            ),
          ])
      ],
    );
  }
}
