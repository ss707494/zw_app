
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/log.dart';
import 'package:zw_app/model/router.dart';

final GlobalKey<NavigatorState> homeNavigationKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> mainNavigationKey = GlobalKey<NavigatorState>();

homePushName(context, String name) {
  if (Provider.of<RouterModel>(context).homeCurrent == name) return;
  Provider.of<RouterModel>(context).homeCurrent = name;
  homeNavigationKey.currentState.pushNamed(name);
}

