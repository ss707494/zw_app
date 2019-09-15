import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/order_item_entity.dart';
import 'package:zw_app/model/order.dart';
import 'package:zw_app/view/main_page/user_center/order_detail.dart';

class PayCompleted extends StatelessWidget {
  final orderId;

  const PayCompleted({Key key, @required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = Provider.of<OrderModel>(context);
    OrderItemEntity orderDetail = orderModel.orderDetail;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.access_alarm),
            onPressed: () async {
              await orderModel.getOrderDetail(context, id: orderId);
            },
            label: Container(),
          ),
        ],
      ),
      body: InitHasLoadingHelp(
        init: () async {
          await orderModel.getOrderDetail(context, id: orderId);
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 400,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 200,
//                    padding: EdgeInsets.only(top: 50, bottom: 50),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.done_outline, color: Colors.white),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('支付成功!',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  Text('感谢您的购买',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 160,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 9,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          right: 30,
                          height: 200,
                          top: 161,
                          child: Stack(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '实付款',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          '\$${orderDetail?.actuallyPaid}',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      height: 1,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                    ),
                                    ...[
                                      ['订单编号: ', orderDetail?.number ?? ''],
                                      ['下单时间: ', DateFormat().format(DateTime.fromMillisecondsSinceEpoch(orderDetail?.createTime ?? 0))],
                                      ['支付方式: ', orderDetail?.paymentMethod?.number ?? ''],
                                    ].map((e) => orderDetail != null ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(e[0]),
                                          Text(e[1])
                                        ],
                                      ),
                                    ) : Container()),
                                  ],
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                        Colors.grey.withOpacity(.5),
                                        Colors.white.withOpacity(.5),
                                      ])),
                                  height: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('继续购物', style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      mainNavigationKey.currentState.pop();
                      pushNameByType(
                        context,
                        'home',
                        'home',
                      );
                    },
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                    child: Text('查看订单详情', style: TextStyle(color: Colors.red),),
                    onPressed: () {
                      mainNavigationKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => OrderDetail(orderId: orderDetail.id)));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
