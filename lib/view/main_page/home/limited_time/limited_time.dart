import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/easy_refresh_cus/easy_refresh_cus.dart';
import 'package:zw_app/component/sliver_app_bar_height/sliver_app_bar_height.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/model/limited_time.dart';

class LimitedTime extends StatelessWidget {
  final ScrollController scrollViewController;

  const LimitedTime({Key key, this.scrollViewController}) : super(key: key);

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

  buildCard(ProductItemEntity item) => Card(
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
                            Text('${item.weight}${item.unit}'),
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
                                '¥${item.priceMarket}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '¥${item.priceOut}',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.red),
                                ),
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
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                Text(
                                  '加入购物车',
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

  @override
  Widget build(BuildContext context) {
    return Consumer<LimitedTimeModel>(
      builder: (_, limitedTimeModel, __) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: EasyRefreshCus(
          outerController: scrollViewController,
          firstRefresh: limitedTimeModel.isInit,
          onRefresh: () async {
            await limitedTimeModel.getListData(context);
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBarHeight(
                customizeHeight: 40,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                titleSpacing: 0,
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '限时抢购: ',
                        style: TextStyle(fontSize: 16),
                      ),
                      buildTimerNumber('1'),
                      buildTimerNumber('1'),
                      Text(':'),
                      buildTimerNumber('1'),
                      buildTimerNumber('1'),
                      Text(':'),
                      buildTimerNumber('1'),
                      buildTimerNumber('1'),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  ...?limitedTimeModel.list.map(buildCard).toList(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
