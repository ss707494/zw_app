import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class SSModal with ChangeNotifier {
  final Map ssObj = {'title': 'ssProvider123'};

  String get title => ssObj['title'];

  int get number => ssObj['number'] ?? 0;

  void changeTitle(v) {
    ssObj['title'] = v;
    notifyListeners();
  }

  void changeNumber(int v) {
    ssObj['number'] = v;
    notifyListeners();
  }
}

class SSProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('${Provider.of<SSModal>(context).title}'),
            ),
            Consumer<SSModal>(
              builder: (_, data, __) => Text('${data.number}'),
            ),
            RaisedButton(
              onPressed: () {
                Provider.of<SSModal>(context).changeTitle('lskdjf');
              },
              child: Text('button'),
            ),
            TextField(
              onChanged: (v) => Provider.of<SSModal>(context).changeNumber(int.parse(v)),
            ),
          ],
        ),
      ),
    );
  }
}
