import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/view/main_page/home/component/header_bar/header_bar.dart';

final GlobalKey<NavigatorState> homeNavigationKey = GlobalKey<NavigatorState>();

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    print(homeNavigationKey.currentState.canPop());
    return MainLayout(
      navigationKey: homeNavigationKey,
      child: NestedNavigator(
        navigationKey: homeNavigationKey,
        initialRoute: 'main/home',
        routes: {
          'main/home': (_) => Text('home'),
          'main/test': (_) => Text('test'),
        },
      ),
//      child: Text('123'),
    );
  }
}
