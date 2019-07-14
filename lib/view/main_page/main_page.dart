import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/view/main_page/home/component/header_bar/header_bar.dart';
import 'package:zw_app/view/main_page/home/home.dart';

final homeNavList = [
  NavObj('home', 'home', widget: (context) => Home()),
  NavObj('test', 'test', icon: Icons.ac_unit, widget: (context) => Text('123')),
];

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: NestedNavigator(
        navigationKey: homeNavigationKey,
        initialRoute: 'home',
        routes: homeNavList.fold({}, (i, e) {
          return {
            ...i,
            e.routeName: e.widget,
          };
        }),
      ),
      navList: homeNavList,
    );
  }
}