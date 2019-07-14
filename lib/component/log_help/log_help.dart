import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/log.dart';
import 'package:zw_app/view/test_page/provider_sample/ss_provider/ss_provider.dart';

class LogHelp extends StatelessWidget {
  final bool showLog;
  final Widget child;

  const LogHelp({this.showLog, this.child});

  @override
  Widget build(BuildContext context) {
    return showLog
        ? Stack(
            fit: StackFit.expand,
            children: <Widget>[
              child,
              Positioned(
                child: Container(
                  height: 50,
                  child: Consumer<LogInfoModel>(
                    builder: (_, data, __) => Text(
                      data.info,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  margin: EdgeInsets.all(6),
                ),
                top: 20,
              )
            ],
          )
        : child;
  }
}
