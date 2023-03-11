import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
}

class MyHomePage extends StatelessWidget {
  //Every widget defines a build() method that's automatically called every time the widget's circumstances change
  @override
  Widget build(BuildContext context) {
    // `MyHomePage` tracks changes to the app's current state using the watch method.
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    //Every build method must return a widget or a nested tree of widgets.
    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME GOOOOD idea:'),
          BigCard(pair: pair),
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
              appState.getNext();
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
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
