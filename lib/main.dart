import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/common/theme.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/component/log_help/log_help.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/component/will_pop_scope_help/will_pop_scope_help.dart';
import 'package:zw_app/model/provider_list.dart';
import 'package:zw_app/view/login/login.dart';
import 'package:zw_app/view/main_page/main_page.dart';
import 'package:zw_app/view/main_page/shopping_cart/confirm_order.dart';

import 'model/http.dart';

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
            child: Builder(
              builder: (context) {
                HttpModel httpModel = Provider.of<HttpModel>(context);
                return InitHelp(
                  init: () async {
                    await httpModel.initToken();
                    if (httpModel.token != null) {
                      mainNavigationKey.currentState.popAndPushNamed('main');
                    } else {
                      mainNavigationKey.currentState.popAndPushNamed('login');
                    }
                  },
                  child: NestedNavigator(
                    navigationKey: mainNavigationKey,
                    initialRoute: 'empty',
                    routes: {
                      'empty': (context) => Container(
                        color: Colors.white,
                      ),
                      'main': (context) => MainPage(),
                      'login': (context) => Login(),
                      'test': (context) => ConfirmOrder(),
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
