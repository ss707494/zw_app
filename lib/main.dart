import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/theme.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/model/login.dart';
import 'package:zw_app/view/main_page/main_page.dart';
import 'package:zw_app/view/test_page/provider_sample/ss_provider/ss_provider.dart';

void main() => runApp(App());

final GlobalKey<NavigatorState> mainNavigationKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => SSModal()),
        ChangeNotifierProvider(builder: (_) => LoginModel()),
      ],
      child: MaterialApp(
        theme: theme,
        home: NestedNavigator(
          navigationKey: mainNavigationKey,
          initialRoute: 'main',
          routes: {
            'main': (context) => MainPage(),
          },
        ),
      ),
    );
  }
}
