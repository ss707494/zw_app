import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/entity/order_item_entity.dart';
import 'package:zw_app/model/order.dart';

import 'order_detail.dart';

enum OrderState { distribution, pick, finish }

List orderStateName = ['', '配货中', '待取货', '订单已完成'];

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderModel orderHistoryModel = Provider.of<OrderModel>(context);
    List<OrderItemEntity> orderList = orderHistoryModel.orderList;
    print(orderList);
    print(orderList.length);

    return Scaffold(
      appBar: AppBar(
        title: Text('订单历史'),
      ),
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          await orderHistoryModel.getData(context);
        },
        child: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            OrderItemEntity orderItem = orderList[index];
            return Column(
              children: <Widget>[
                Container(height: 4, color: Colors.grey.withAlpha(50)),
                InkWell(
                  onTap: () {
                    mainNavigationKey.currentState.push(MaterialPageRoute(
                        builder: (context) =>
                            OrderDetail(orderId: orderItem.id)));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(DateFormat().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      orderItem?.createTime ?? 0))),
                              Text(getOrderStateByIndex(orderItem.state)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: List.generate(
                                  min(4, orderItem.product.length), (index1) {
                                var imgItem = orderItem.product[index1];
                                return imgItem != null
                                    ? Container(
                                        height: 60,
                                        width: 60,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: ImageErrHelp(
                                            imageUrl: imgItem.oneImgUrl,
                                          ),
                                        ),
                                      )
                                    : Container();
                              }),
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerRight,
                          child: Text(
                              '共${orderItem.product.length}件商品 实付\$${orderItem.actuallyPaid}'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
