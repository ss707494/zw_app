import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/view/main_page/home/home.dart';
import 'package:zw_app/view/main_page/user_center/user_center.dart';

final homeNavList = [
  NavObj('逛店', 'home', widget: Home()),
  NavObj('拼乐', 'limited_time', icon: Icons.ac_unit, widget: Text('123')),
  NavObj('达人专区', 'hot', widget: Text('123')),
  NavObj('购物车', 'car', icon: Icons.add_a_photo, widget: Text('123')),
  NavObj('我', 'user_center', widget: UserCenter()),
];

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: NestedNavigator(
        initialRoute: homeNavList[0].routeName,
        navigationKey: homeNavigationKey,
        routes: getRouterByNavList(homeNavList),
      ),
      navList: homeNavList,
    );
  }
}
