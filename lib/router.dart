import 'package:flutter/widgets.dart';
import 'package:zw_app/view/home/classifications/classifications.dart';
import 'package:zw_app/view/home/home.dart';
import 'package:zw_app/view/home/limited_time/limited_time.dart';
import 'package:zw_app/view/test_page/TabBarBottom.dart';
import 'package:zw_app/view/test_page/test_page.dart';

initialRoute() {
  return 'home/classifications';
}

final Map<String, WidgetBuilder> routers = {
  '/': (BuildContext context) => Home(),
  'home': (BuildContext context) => Home(),
  'home/classifications': (BuildContext context) => Classifications(),
  'home/limitedTime': (BuildContext context) => LimitedTime(),
  'test': (BuildContext context) => Test(),
  'tabBarBottom': (BuildContext context) => TabBarBottom(),
};
