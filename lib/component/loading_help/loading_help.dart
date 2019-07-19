import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/http_loading.dart';

class LoadingHelp extends StatelessWidget {
  final Widget child;
  final String path;

  const LoadingHelp({Key key, @required this.child, @required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final httpLoadingModel = Provider.of<HttpLoadingModel>(context);
    return path != null && httpLoadingModel.getOne(path)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : child;
  }
}
