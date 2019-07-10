import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zw_app/common/help_obj.dart';

final navList = [
  NavObj('test', 'test', 'test', icon: Icons.ac_unit ),
  NavObj('home', 'home/classifications', 'home'),
  NavObj('tabBarBottom', 'tabBarBottom', 'tabBarBottom'),
];

class MainLayout extends StatelessWidget {
  final Widget child;
  final automaticallyImplyLeading;

  const MainLayout(
      {Key key, this.automaticallyImplyLeading = false, this.child})
      : super(key: key);

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
            child: child,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (active) {
          Navigator.pushNamed(context, navList[active].routeName);
        },
        currentIndex: max(0, navList
            .indexWhere((e) => ModalRoute.of(context).settings.name.contains(e.routeNameRoot))),
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
