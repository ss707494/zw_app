import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/confirm_dialog/confirm_dialog.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/order_item_entity.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/model/order.dart';
import 'package:zw_app/model/shopping_cart.dart';

class OrderDetail extends StatelessWidget {
  final String orderId;

  const OrderDetail({Key key, @required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = Provider.of<OrderModel>(context);
    OrderItemEntity orderDetail = orderModel.orderDetail;
    ShoppingCartModel shoppingCartModel =
        Provider.of<ShoppingCartModel>(context);

    Widget buildProduct(item) => Container(
          height: 90,
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: <Widget>[
              Container(
                width: 90,
                height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageErrHelp(
                    imageUrl: item?.oneImgUrl == null ? '' : item.oneImgUrl,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(item.name),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${item.weight}${item.unit}'),
                      ],
                    ),
                    Expanded(child: Text('${item.remark}')),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '\$${item.priceMarket}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '\$${item.priceOut}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.grey.withAlpha(100),
                              child: Text('加入购物车'),
                              onPressed: () {
                                showConfirmDialog(
                                  context: context,
                                  content: Text('确认加入购物车'),
                                  handleOk: () async {
                                    shoppingCartModel.addToShopCart(context,
                                        productId: item.id);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('订单详情'),
        centerTitle: true,
      ),
      body: InitHasLoadingHelp(
        init: () async {
          if (orderDetail.id != orderId) {
            await orderModel.getOrderDetail(context, id: orderId);
          }
        },
        child: orderDetail != null
            ? ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                                DateFormat().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        orderDetail?.createTime ?? 0)),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                  getOrderStateByIndex(orderDetail.state),
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          children: <Widget>[
                            Text('送货地址: '),
                            Text(orderDetail?.address?.address ?? ''),
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          children: <Widget>[
                            Text('订单编号: '),
                            Text(orderDetail?.number ?? ''),
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          children: <Widget>[
                            Text('支付方式: '),
                            Text(orderDetail?.paymentMethod?.number ?? ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey.withAlpha(50),
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: List.generate(orderDetail?.product?.length ?? 0,
                          (index) {
                        ProductItemEntity item = orderDetail?.product[index];
                        return buildProduct(item);
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        ...[
                          ['小计', orderDetail?.subtotal],
                          ['优惠券折扣', -orderDetail?.couponDiscount],
                          ['运费', orderDetail?.transportationCosts],
                          ['达人币抵扣', orderDetail?.vipDiscount],
                          ['消费税', orderDetail?.saleTax],
                        ]
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: <Widget>[
                                      Text(e[0]),
                                      Spacer(),
                                      Text(
                                        '\$${e[1].toString()}',
                                        style: TextStyle(
                                          color:
                                              double.tryParse(e[1].toString()) <
                                                      0
                                                  ? Colors.red
                                                  : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        Row(
                          children: <Widget>[
                            Text('订单总额',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            Spacer(),
                            Text(
                              '\$${orderDetail?.actuallyPaid}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
