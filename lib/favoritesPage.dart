import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;

    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text('You have '
            '${appState.favorites.length} favorites:'),
      ),
      for (var favorite in favorites)
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text(favorite.asLowerCase),
        ),
    ]);
  }
}
