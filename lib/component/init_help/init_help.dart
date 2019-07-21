import 'package:flutter/material.dart';

class InitHelp extends StatefulWidget {
  final Widget child;
  final Function init;
  final Function didChangeDependencies;

  const InitHelp({Key key, this.child, this.init, this.didChangeDependencies}) : super(key: key);

  @override
  _InitHelpState createState() => _InitHelpState();
}

class _InitHelpState extends State<InitHelp> {
  @override
  void initState () {
    super.initState();
    if (widget.init != null) {
      widget?.init();
    }
  }

  @override
  didChangeDependencies () {
    super.didChangeDependencies();
    if (widget.didChangeDependencies != null) {
      widget?.didChangeDependencies();
    }
  }


  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
