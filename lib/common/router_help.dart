
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/router.dart';

final GlobalKey<NavigatorState> homeNavigationKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> mainNavigationKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> shopNavigationKey = GlobalKey<NavigatorState>();

final helpKey = {
  'main': mainNavigationKey,
  'home': homeNavigationKey,
  'shop': shopNavigationKey,
};

pushNameByType(context, type, name) {
  if (Provider.of<RouterModel>(context).getCurrent(type) == name) return;
  Provider.of<RouterModel>(context).setCurrent(type, name);
  helpKey[type].currentState.pushNamed(name);
}

homePushName(context, String name) {
  if (Provider.of<RouterModel>(context).homeCurrent == name) return;
  Provider.of<RouterModel>(context).homeCurrent = name;
  homeNavigationKey.currentState.pushNamed(name);
}

shopPushName(context, String name) {
  if (Provider.of<RouterModel>(context).shopCurrent == name) return;
  Provider.of<RouterModel>(context).shopCurrent = name;
  shopNavigationKey.currentState.pushNamed(name);
}

