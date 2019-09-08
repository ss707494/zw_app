import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/http.dart';

class InitHasLoadingHelp extends StatefulWidget {
  final Widget child;
  final Function init;
  final Function didChangeDependencies;
  final String path;

  const InitHasLoadingHelp({Key key, this.child, this.init, this.didChangeDependencies, this.path}) : super(key: key);

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
    bool isLoading = _isLoading;
    if (widget.path != null) {
      final httpLoadingModel = Provider.of<HttpModel>(context);
      isLoading = isLoading || httpLoadingModel.getOne(widget.path);
    }
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
