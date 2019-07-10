import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/theme.dart';
import 'package:zw_app/model/login.dart';
import 'package:zw_app/router.dart';
import 'package:zw_app/view/test_page/provider_sample/ss_provider/ss_provider.dart';

void main() => runApp(App());

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
        initialRoute: initialRoute(),
        routes: routers,
      ),
    );
  }
}
