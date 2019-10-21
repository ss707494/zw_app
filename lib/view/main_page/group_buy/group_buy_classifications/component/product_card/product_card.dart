import 'package:flutter/material.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/view/main_page/group_buy/order_confirm/group_product_detail.dart';

class GroupProductCard extends StatelessWidget {
  final ProductItemEntity item;

  const GroupProductCard({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    ShoppingCartModel shoppingCartModel = Provider.of<ShoppingCartModel>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 120,
                  child: CarouselSliderIndicator(
                    aspectRatio: 1 / 1,
                    items: [
                      ...(item.imgs?.length ?? 0) > 0
                          ? item.imgs
                          ?.map((e) => Container(
                        child: ImageErrHelp(
                          imageUrl: e.url,
                        ),
                      ))
                          ?.toList()
                          : []
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(item.name),
                              Container(
                                width: 10,
                              ),
                              Text('('),
                              Row(
                                children: <Widget>[
                                  Text(item?.groupRemark ?? ''),
                                  Text(
                                      '/共${item.groupAmount}${item.unit}/${item.groupPrecision}份制'),
                                ],
                              ),
                              Text(')'),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withAlpha(200),
                            ),
                            child: Text(
                              '当前剩余: ${item.stock}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '169',
                                  style: TextStyle(fontSize: 17, color: Colors.red),
                                ),
                                Text(
                                  '单 已成团',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text('市场价 '),
                              Text(
                                '\$${item.priceMarket}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '基准价格 ',
                                  style: TextStyle(fontSize: 17, color: Colors.red),
                                ),
                                Text(
                                  '\$${item.priceOut}/${item.unit}',
                                  style: TextStyle(fontSize: 17, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            child: RaisedButton(
                              padding: EdgeInsets.all(2),
                              elevation: 1,
                              color: Colors.red,
                              onPressed: () async {
                                mainNavigationKey.currentState.push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GroupProductDetail(product: item)));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  Container(width: 5),
                                  Text(
                                    '拼一个',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
//                    icon: Icon(Icons.shopping_cart,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
