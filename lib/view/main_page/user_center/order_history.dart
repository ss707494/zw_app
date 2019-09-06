import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/model/order_history.dart';

import 'order_detail.dart';

enum OrderState {
  distribution,
  pick,
  finish
}

List orderStateName = ['', '配货中', '待取货', '订单已完成'];

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderHistoryModel orderHistoryModel = Provider.of<OrderHistoryModel>(context);
    List orderList = orderHistoryModel.orderList;

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
            var orderItem = orderList[index];
            return Column(
              children: <Widget>[
                Container(height: 4, color: Colors.grey.withAlpha(50)),
                InkWell(
                  onTap: () {
                    mainNavigationKey.currentState.push(MaterialPageRoute(builder: (context) => OrderDetail(id: orderItem['id'])));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(orderItem['time']),
                              Text(orderStateName[orderItem['state']]),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: List.generate(min(4, orderItem['productList'].length), (index1) {
                                var imgItem = orderItem['productList'][index1];
                                return imgItem != null ? Container(
                                  height: 60,
                                  width: 60,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: ImageErrHelp(
                                      imageUrl: imgItem['imgUrl'],
                                    ),
                                  ),
                                ) : Container();
                              }),
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerRight,
                          child: Text('共${orderItem['productNumber']}件商品 实付\$${orderItem['amount']}'),
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
