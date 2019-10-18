import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/group_queue_entity.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/graphql_document/group.dart';
import 'package:zw_app/model/group_shopping_cart.dart';
import 'package:zw_app/view/main_page/group_buy/order_confirm/group_shopping_cart.dart';

class GroupProductDetail extends StatefulWidget {
  final ProductItemEntity product;

  const GroupProductDetail({Key key, @required this.product}) : super(key: key);

  @override
  _GroupProductDetailState createState() => _GroupProductDetailState();
}

class _GroupProductDetailState extends State<GroupProductDetail> {
  @override
  Widget build(BuildContext context) {
    GroupShoppingCartModel groupShoppingCartModel =
        Provider.of<GroupShoppingCartModel>(context);
    int selectStar = groupShoppingCartModel.selectStar;

    ProductItemEntity item = widget?.product;
    starIcon({Color color, double size: 22.0}) =>
        Icon(Icons.star, size: size, color: color ?? Colors.yellow[700]);

    Widget grouping = Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('拼团中',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Container(height: 4),
          ...List.generate(groupShoppingCartModel.groupQueueListDoing.length,
              (index) {
            GroupQueueEntity groupItem =
                groupShoppingCartModel.groupQueueListDoing[index];
            bool isItemFinish = item.groupPrecision ==
                groupItem.selectAmount + groupItem.fillAmount;
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isItemFinish ? Colors.red : Colors.grey.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ...List.generate(
                          groupItem.fillAmount, (index) => starIcon()),
                      ...List.generate(
                          groupItem.selectAmount,
                          (index) => starIcon(
                              color: Colors.yellow[700].withAlpha(100))),
                      ...List.generate(
                          item.groupPrecision -
                              groupItem.selectAmount -
                              groupItem.fillAmount,
                          (index) =>
                              starIcon(color: Colors.grey.withAlpha(150))),
                    ],
                  ),
                  Row(
                    children: isItemFinish
                        ? [
                            Text('成团啦', style: TextStyle(color: Colors.white)),
                          ]
                        : [
                            Text('未成团', style: TextStyle(color: Colors.grey)),
                          ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );

    Widget smartMatch() => Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Text('智能匹配',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  FlatButton(
                    child: Text('查看拼团折扣价格表>'),
                    onPressed: () {},
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('请点击'),
                  starIcon(color: Colors.grey.withAlpha(150), size: 18),
                  Text(', 确认您需要的份数')
                ],
              ),
              Container(height: 10),
              Row(
                children: <Widget>[
                  ...List.generate(
                      item.groupPrecision,
                      (index) => GestureDetector(
                            onTap: () {
                              groupShoppingCartModel.changeSelectStar(
                                  selectStar == index + 1 ? index : index + 1,
                                  item);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 6),
                              child: starIcon(
                                  size: 30,
                                  color: index >= selectStar
                                      ? Colors.grey.withAlpha(150)
                                      : null),
                            ),
                          )),
                ],
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('拼团'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: InitHasLoadingHelp(
              path: getGroupDetail,
              init: () async {
                await groupShoppingCartModel.initGroupData(context);
              },
              child: ListView(
                children: <Widget>[
                  CarouselSliderIndicator(
                    items: [
                      ...item?.imgs
                              ?.map((e) => ImageErrHelp(
                                    imageUrl: e.url,
                                  ))
                              ?.toList() ??
                          []
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.red.withAlpha(150)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('基准价格 '),
                              Text('\$${item.priceOut}/${item.unit}')
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                  '已成团 ${groupShoppingCartModel.groupQueueList.length - groupShoppingCartModel.groupQueueListDoing.length}单'),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54.withAlpha(80),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                                child: Text(
                                    '拼团中 ${groupShoppingCartModel.groupQueueListDoing.length}单'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Text(item.name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Container(width: 6),
                        Text('('),
                        Row(
                          children: <Widget>[
                            Text(item.groupRemark),
                            Text('/共${item.groupAmount}${item.unit}/分团精度'),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black.withAlpha(200),
                              ),
                              child: Row(
                                children: List.generate(
                                    item.groupPrecision,
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3, vertical: 2),
                                          child: starIcon(size: 14.0),
                                        )).toList(),
                              ),
                            ),
                          ],
                        ),
                        Text(')'),
                      ],
                    ),
                  ),
                  grouping,
                  smartMatch(),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 1,
                  color: Colors.grey.withAlpha(50),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.center,
                                    height: 25,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            '\$${groupShoppingCartModel.getUnitPrice(item.priceOut.toDouble())}',
                                            style: TextStyle(fontSize: 20)),
                                        Text(' = '),
                                      ],
                                    )),
                                Text('折后价格'),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  child: Text('\$${item.priceOut}'),
                                ),
                                Text('基准价格'),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 25,
                              child: Text('x'),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  child: Text(
                                      '${groupShoppingCartModel.groupCopiesDiscount}'),
                                ),
                                Text('份数折扣'),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 25,
                              child: Text('x'),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  child: Text(
                                      '${groupShoppingCartModel.groupFinishDiscount}'),
                                ),
                                Text('成团折上折',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              '选择了$selectStar份 ${selectStar * item.groupAmount / item.groupPrecision}${item.unit}, 总价 \$${Decimal.parse(groupShoppingCartModel.getUnitPrice(item.priceOut.toDouble()).toString()) * Decimal.parse(selectStar.toString())}',
                              style: TextStyle(color: Colors.red)),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              if (selectStar == 0) {
                                Fluttertoast.showToast(msg: '请先选择拼团份数');
                              }
                              groupShoppingCartModel.addToShopCart(context,
                                  product: item);
                              mainNavigationKey.currentState.push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GroupShoppingCart()));
                            },
                            child: Text(
                              '结算',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
