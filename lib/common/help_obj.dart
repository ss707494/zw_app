import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRouterByNavList(List<NavObj> list) =>
    list.fold({}, (i, e) {
      return {
        ...i,
        e.routeName: e.widgetBuilder,
      };
    });

class NavObj {
  final icon;
  final String title;
  final String routeName;
  final String routeNameRoot;
  final Widget widget;
  final clazz;

  get widgetBuilder => (BuildContext context) => widget;
//  get widgetBuilderByClassData => (BuildContext context) => clazz();

  const NavObj(
    this.title,
    this.routeName, {
    this.icon = Icons.home,
    this.routeNameRoot = '',
    this.widget,
    this.clazz,
  });
}
