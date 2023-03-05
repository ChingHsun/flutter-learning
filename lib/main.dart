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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
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

    //Every build method must return a widget or a nested tree of widgets.
    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME GOOOOD idea:'),
          Text(appState.current.asLowerCase),
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
