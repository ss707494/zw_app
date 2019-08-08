import 'package:flutter/material.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/common/theme.dart';
import 'package:zw_app/component/log_help/log_help.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/component/will_pop_scope_help/will_pop_scope_help.dart';
import 'package:zw_app/model/provider_list.dart';
import 'package:zw_app/view/main_page/main_page.dart';
import 'package:zw_app/view/main_page/shopping_cart/confirm_order.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderHelp(
      child: MaterialApp(
        theme: theme,
        home: LogHelp(
          showLog: false,
          child: WillPopScopeHelp(
            child: NestedNavigator(
              navigationKey: mainNavigationKey,
              initialRoute: 'test',
              routes: {
                'main': (context) => MainPage(),
                'test': (context) => ConfirmOrder(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
