import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BigCard(pair: pair),
      SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                appState.toggleFavorite();
              },
              icon: Icon(icon),
              label: Text('Like')),
          SizedBox(width: 10),
          ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'))
        ],
      )
    ]));
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    //he theme's displayMedium property could theoretically be null. Dart is null-safe so use !
    // copyWith() on displayMedium returns a copy of the text style with the changes you define. In this case, you're only changing the text's color
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    // flutter uses Composition over Inheritance whenever it can. Here, instead of padding being an attribute of Text, it's a widget!
    //  This way, widgets can focus on their single responsibility, to have freedom in how to compose your UI.
    //For example, you can use the Padding widget to pad text, images, buttons, your own custom widgets, or the whole app.
    // The widget doesn't care what it's wrapping.
    return Card(
      elevation: 20,
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          // accessibility screen reader
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
