import 'package:flutter/material.dart';

class InitHasLoadingHelp extends StatefulWidget {
  final Widget child;
  final Function init;
  final Function didChangeDependencies;

  const InitHasLoadingHelp({Key key, this.child, this.init, this.didChangeDependencies}) : super(key: key);

  @override
  _InitHasLoadingHelpState createState() => _InitHasLoadingHelpState();
}

class _InitHasLoadingHelpState extends State<InitHasLoadingHelp> {
  bool _isLoading = false;

  doInit () async {
    setState(() {
      _isLoading = true;
    });
    if (widget.init != null) {
      await widget?.init();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState () {
    super.initState();
    doInit();
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
    return Stack(
      children: <Widget>[
        ..._isLoading ? [Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: RefreshProgressIndicator(),
          ),
        )] : [],
        Container(child: widget.child),
      ],
    );
  }
}
