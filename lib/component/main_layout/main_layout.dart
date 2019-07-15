import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/model/log.dart';
import 'package:zw_app/model/router.dart';
import 'package:zw_app/view/main_page/main_page.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final automaticallyImplyLeading;
  final List<NavObj> navList;

  const MainLayout({
    Key key,
    this.automaticallyImplyLeading = false,
    this.child,
    @required this.navList,
  })  : assert(navList.length > 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Container(
          height: 30,
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 24),
              filled: true,
              fillColor: Colors.grey[300],
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('热搜:'),
              Text('乐事薯片'),
              Text('牛奶'),
            ],
          ),
          Expanded(
            child: Container(child: child),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (active) {
          homePushName(context, navList[active].routeName);
        },
        currentIndex: max(
            0,
            navList?.indexWhere((e) => Provider.of<RouterModel>(context)
                ?.homeCurrent
                ?.contains(e.routeName))),
        items: [
          ...navList
              .map((e) => BottomNavigationBarItem(
                    icon: Icon(e?.icon),
                    title: Text(e?.title),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
