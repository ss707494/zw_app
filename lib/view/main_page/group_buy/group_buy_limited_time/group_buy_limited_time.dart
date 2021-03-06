import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/easy_refresh_cus/easy_refresh_cus.dart';
import 'package:zw_app/entity/group_queue_entity.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/model/group_limited_time.dart';
import 'package:zw_app/view/main_page/group_buy/order_confirm/group_product_detail.dart';

class GroupBuyLimitedTime extends StatelessWidget {
  final ScrollController scrollViewController;

  const GroupBuyLimitedTime({Key key, this.scrollViewController})
      : super(key: key);

  buildTimerNumber(String text) => Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        padding: EdgeInsets.all(4),
        color: Colors.black.withAlpha(200),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      );

  buildCard(GroupQueueEntity groupQueueEntity, {context}) {
    ProductItemEntity item = groupQueueEntity.product;

    starIcon({Color color, double size: 14.0}) =>
        Icon(Icons.star, size: size, color: color ?? Colors.yellow[700]);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
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
                                child: Image.network(
                                  '$e',
                                  fit: BoxFit.fill,
                                ),
                              ))
                          ?.toList()
                      : []
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                              Text(item.groupRemark),
                              Text(
                                  '/共${item.groupAmount}${item.unit}/${item.groupPrecision}份制'),
                            ],
                          ),
                          Text(')'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          ...List.generate(groupQueueEntity.fillAmount,
                              (index) => starIcon()),
                          ...List.generate(
                              item.groupPrecision - groupQueueEntity.fillAmount,
                              (index) =>
                                  starIcon(color: Colors.grey.withAlpha(150))),
                        ],
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupLimitedTimeModel>(
      builder: (_, limitedTimeModel, __) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: EasyRefreshCus(
          outerController: scrollViewController,
          firstRefresh: true,
          onRefresh: () async {
            await limitedTimeModel.getListData(context);
          },
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  ...?limitedTimeModel.list
                      .map((e) => buildCard(e, context: context))
                      .toList(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
