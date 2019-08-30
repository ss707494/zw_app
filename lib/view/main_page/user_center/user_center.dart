import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/entity/user_coin_entity.dart';
import 'package:zw_app/entity/user_info_entity.dart';
import 'package:zw_app/model/shopping_cart.dart';
import 'package:zw_app/model/user_center.dart';
import 'package:zw_app/view/main_page/user_center/order_history.dart';

class UserCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserCenterModel userCenterModel = Provider.of<UserCenterModel>(context);
    UserInfoEntity userInfo = userCenterModel.userInfo;
    UserCoinEntity userCoin = userCenterModel.userCoin;
    ShoppingCartModel shoppingCartModel = Provider.of<ShoppingCartModel>(context);

    const mainPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 10);

    Widget line = Container(
      height: 8,
      color: Colors.grey.withAlpha(50),
    );

    Widget mainBox(child, { padding = mainPadding }) => Container(
          padding: padding,
//          color: Colors.white,
          child: child,
        );

    Widget headerInfo = mainBox(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 30),
        Text('你好, ${userInfo.userName ?? ''}'),
        Text('${userInfo.phone ?? ''}'),
        Text('${userInfo.email ?? ''}')
      ],
    ));

    Widget coinsBox = mainBox(Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(Icons.local_atm),
            Text('\$${userCoin.currentMouthIcons}'),
            Text('当月达人币'),
          ],
        ),
        Column(
          children: <Widget>[
            Icon(Icons.local_atm),
            Text('\$${userCoin.nextMouthIcons}'),
            Text('下月达人币'),
          ],
        ),
        Column(
          children: <Widget>[
            Icon(Icons.credit_card),
            Text('${userCoin.cardNumber}'),
            Text('达人卡'),
          ],
        ),
      ],
    ));

    Widget orderBox = mainBox(Column(
      children: <Widget>[
        ListTile(
          title: Text('我的订单历史'),
          subtitle: Text('${userCenterModel.orderList.length ?? 0}个订单待取货'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            mainNavigationKey.currentState.push(MaterialPageRoute(
              builder: (context) => OrderHistory(),
            ));
          },
        ),
        Divider(),
        ListTile(
          title: Text('下次买清单'),
          subtitle: Text('${shoppingCartModel.nextProductList.length ?? 0}件商品'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    ), padding: EdgeInsets.symmetric(horizontal: 0));

    Widget myInfoBox = mainBox(Column(
      children: <Widget>[
        ListTile(
          title: Text('我的达人卡'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          title: Text('我的信用卡'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {},
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
          onTap: () {},
        ),
        Divider(),
        ListTile(
          title: Text('帮助中心'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {},
        ),
      ],
    ), padding: EdgeInsets.symmetric(horizontal: 0));

    return SafeArea(
      child: Scaffold(
        body: EasyRefresh(
          firstRefresh: true,
          header: MaterialHeader(),
          onRefresh: () async {
            await userCenterModel.getData(context);
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
