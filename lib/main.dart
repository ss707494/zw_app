import 'package:flutter/material.dart';
import 'package:zw_app/router.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: routers,);
  }
}

