
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zw_app/common/router_help.dart';

DateTime currentBackPressTime;

class WillPopScopeHelp extends StatelessWidget {
  final Widget child;

  WillPopScopeHelp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async {
        if (mainNavigationKey.currentState.canPop()) {
          mainNavigationKey.currentState.pop();
          return Future.value(false);
        }
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: '再次点击返回键退出应用');
          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}
