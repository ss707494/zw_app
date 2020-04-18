import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/common/storeModel/storeModel.dart';
import 'package:zw_app/model/login.dart';
import 'package:zw_app/model/router.dart';
import 'package:zw_app/model/shopping_cart.dart';
import 'package:zw_app/type__graphql/model/user_center.dart';
import 'package:zw_app/view/main_page/sys_dev/sys_dev.dart';
import 'package:zw_app/view/main_page/user_center/help_info.dart';
import 'package:zw_app/view/main_page/user_center/my_address_list.dart';
import 'package:zw_app/view/main_page/user_center/my_pay_card_list.dart';
import 'package:zw_app/view/main_page/user_center/order_history.dart';

import 'group_order_history.dart';
import 'my_user_info.dart';

class UserCenter extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final userCenterModelStore = useStoreModel(userCenterModelDate);
    final uCHelp = userCenterModelStore.helpAction;
    final uCState = userCenterModelStore.state;
    final uCActions = userCenterModelStore.actions;

    ShoppingCartModel shoppingCartModel =
        Provider.of<ShoppingCartModel>(context);

    const mainPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 10);

    Widget line = Container(
      height: 8,
      color: Colors.grey.withAlpha(50),
    );

    Widget mainBox(child, {padding = mainPadding}) => Container(
          padding: padding,
//          color: Colors.white,
          child: child,
        );

    Widget headerInfo = mainBox(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 30),
        Text(
          '你好, ${uCState.user?.userInfo?.name ?? ''}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Container(height: 20),
        Text('${uCState.user?.userInfo?.phone ?? ''}'),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('${uCState.user?.userInfo?.email ?? ''}'),
            ),
            Spacer(),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: Colors.grey.withAlpha(100),
                  )),
              child: Text('登出'),
              onPressed: () async {
                Provider.of<RouterModel>(context)
                    ?.setCurrent('home', 'home');
                LoginModel loginModel = Provider.of<LoginModel>(context);
                await loginModel.loginOut(context);
              },
            ),
          ],
        ),
      ],
    ));

    Widget coinsBox = mainBox(Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.local_atm),
              Container(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('\$${uCState.user?.orderCoinCurrentMonth ?? 0}'),
                  Text('当月达人币'),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.local_atm),
              Container(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('\$${uCState.user?.orderCoinNextMonth ?? 0}'),
                  Text('下月达人币'),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.credit_card),
              Container(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${0}'),
                  Text('达人卡'),
                ],
              ),
            ],
          ),
        ],
      ),
    ));

    Widget orderBox = mainBox(
        Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text(
                '我的订单历史',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                mainNavigationKey.currentState.push(MaterialPageRoute(
                  builder: (context) => OrderHistory(),
                ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text(
                '拼团订单历史',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                mainNavigationKey.currentState.push(MaterialPageRoute(
                  builder: (context) => GroupOrderHistory(),
                ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.drafts),
              title: Text('下次买清单',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('${shoppingCartModel.nextProductList.length ?? 0}件商品'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 0));

    Widget myInfoBox = mainBox(
        Column(
          children: <Widget>[
            ListTile(
              title: Text('我的达人卡'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                mainNavigationKey.currentState.push(MaterialPageRoute(
                    builder: (context) => MyUserInfo()
                ));
              },
            ),
            Divider(),
            ListTile(
              title: Text('我的信用卡'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                mainNavigationKey.currentState.push(MaterialPageRoute(
                    builder: (context) => MyPayCardList()
                ));
              },
            ),
            Divider(),
            ListTile(
              title: Text('我的取货点'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('我的地址'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                mainNavigationKey.currentState.push(MaterialPageRoute(
                  builder: (context) => MyAddressList()
                ));
              },
            ),
            Divider(),
            ListTile(
              title: Text('帮助中心'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                mainNavigationKey.currentState.push(MaterialPageRoute(
                    builder: (context) => HelpInfo()
                ));
              },
            ),
            ListTile(
              title: Text('开发者设置'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                mainNavigationKey.currentState.push(MaterialPageRoute(
                    builder: (context) => SysDev()
                ));
              },
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 0));

    return SafeArea(
      child: Scaffold(
        body: EasyRefresh(
          firstRefresh: true,
          header: MaterialHeader(),
          onRefresh: () async {
            await uCActions.getData(uCHelp)();
          },
          child: ListView(
            children: <Widget>[
              headerInfo,
              line,
              coinsBox,
              line,
              orderBox,
              line,
              myInfoBox,
              line,
            ],
          ),
        ),
      ),
    );
  }
}
