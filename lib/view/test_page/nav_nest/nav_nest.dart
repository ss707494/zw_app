import 'package:flutter/material.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested Routing Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Root App Bar'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 72,
            color: Colors.cyanAccent,
            padding: EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Change Inner Route: '),
                RaisedButton(
                  onPressed: () {
                    while (navigationKey.currentState.canPop())
                      navigationKey.currentState.pop();
                  },
                  child: Text('to Root'),
                ),
              ],
            ),
          ),
          Expanded(
            child: NestedNavigator(
              navigationKey: navigationKey,
              initialRoute: 'one',
              routes: {
                // default rout as '/' is necessary!
                'one': (context) => PageOne(),
                'two': (context) => PageTwo(),
                'three': (context) => PageThree(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

// nested_navigator
class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page One'),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('two');
              },
              child: Text('to Page Two'),
            ),
          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page Two'),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('three');
              },
              child: Text('go to next'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('go to back'),
            ),
          ],
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page Three'),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('go to back'),
            ),
          ],
        ),
      ),
    );
  }
}
