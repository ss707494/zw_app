import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/model/router.dart';
import 'package:zw_app/model/shopping_cart.dart';
import 'package:zw_app/view/main_page/home/home.dart';
import 'package:zw_app/view/main_page/shopping_cart/shopping_cart.dart';
import 'package:zw_app/view/main_page/sys_dev/sys_dev.dart';
import 'package:zw_app/view/main_page/user_center/user_center.dart';

final homeNavList = [
  NavObj('逛店', 'home', widget: Home()),
  NavObj('拼乐', 'limited_time', icon: Icons.ac_unit, widget: Text('123')),
  NavObj('达人专区', 'hot', widget: Text('123')),
  NavObj('购物车', 'shopping_cart',
      icon: Icons.shopping_cart, widget: ShoppingCart()),
  NavObj('我', 'user_center',
      icon: Icons.supervised_user_circle, widget: UserCenter()),
];

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedNavigator(
        initialRoute: homeNavList[0].routeName,
        navigationKey: homeNavigationKey,
        routes: getRouterByNavList(homeNavList),
      ),
      bottomNavigationBar: InitHelp(
        init: () {
          Provider.of<ShoppingCartModel>(context).getData(context);
        },
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (active) {
            pushNameByType(
              context,
              'home',
              homeNavList[active].routeName,
            );
          },
          currentIndex: max(
              0,
              homeNavList?.indexWhere((e) =>
                  Provider.of<RouterModel>(context)
                      ?.getCurrent('home')
                      ?.contains(e.routeName) ??
                  false)),
          items: [
            ...homeNavList.map((e) {
              var shopData = Provider.of<ShoppingCartModel>(context);
              return BottomNavigationBarItem(
                icon: e?.title == '购物车' && shopData.productList.length > 0
                    ? Stack(
                        children: <Widget>[
                          Icon(e?.icon),
                          Positioned(
                            top: -2,
                            right: -16,
                            child: Container(
                              child: Center(
                                child: Text('${shopData.productList.length}',
                                    style: TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                        overflow: Overflow.visible,
                      )
                    : Icon(e?.icon),
                title: Text(e?.title),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () {
          // 调试测试
          mainNavigationKey.currentState.push(MaterialPageRoute(
            builder: (context) => SysDev()
          ));
        },
      ),
    );
  }
}
