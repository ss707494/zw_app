import 'package:flutter/material.dart';

class InitHelp extends StatefulWidget {
  final Widget child;
  final Function init;

  const InitHelp({Key key, this.child, @required this.init}) : super(key: key);

  @override
  _InitHelpState createState() => _InitHelpState();
}

class _InitHelpState extends State<InitHelp> {
  @override
  void initState () {
    widget.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
