import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favoritesPage.dart';
import 'generatorPage.dart';

//At the very top of the file, you'll find the main() function.
//In its current form, it only tells Flutter to run the app defined in MyApp.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              // Color.fromRGBO(0, 255, 0, 1.0),  Color(0xFF00FF00).
              seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// The state is created and provided to the whole app using a ChangeNotifierProvider.
//This allows any widget in the app to get hold of the state.
class MyAppState extends ChangeNotifier {
  //WordPair provides several helpful getters, such as asPascalCase or asSnakeCase.
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  //Every widget defines a build() method that's automatically called every time the widget's circumstances change
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    //Every build method must return a widget or a nested tree of widgets.
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        // 水平 center
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                      icon: Icon(Icons.home), label: Text('Home')),
                  NavigationRailDestination(
                      icon: Icon(Icons.favorite), label: Text('Favorites'))
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
                child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: page))
          ],
        ),
      );
    });
  }
}
