import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/easy_refresh_cus/easy_refresh_cus.dart';
import 'package:zw_app/component/easy_refresh_cus/lib/easy_refresh.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/sliver_app_bar_height/sliver_app_bar_height.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/model/group_home_sales.dart';
import 'package:zw_app/view/main_page/group_buy/order_confirm/group_product_detail.dart';

class GroupBuyHomeSales extends StatelessWidget {
  final ScrollController scrollViewController;
  final GlobalKey<EasyRefreshState> refreshKey = GlobalKey<EasyRefreshState>();

  GroupBuyHomeSales({Key key, this.scrollViewController}) : super(key: key);

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

  buildCard(ProductItemEntity item, {index, context}) {

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
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
                                  Text(item.groupRemark),
                                  Text(
                                      '/共${item.groupAmount}${item.unit}/${item.groupPrecision}份制'),
                                ],
                              ),
                              Text(')'),
                            ],
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == 0
                      ? Colors.yellowAccent[700]
                      : index == 1
                          ? Colors.grey[700]
                          : index == 2 ? Colors.lime[700] : Colors.black54,
                ),
                child:
                    Text('${index + 1}', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupHomeSalesModel>(
      builder: (_, homeSalesModel, __) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: EasyRefreshCus(
          easyRefreshKey: refreshKey,
          outerController: scrollViewController,
          firstRefresh: homeSalesModel.isInit,
          onRefresh: () async {
            await homeSalesModel.getListData(context);
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBarHeight(
                customizeHeight: 40,
                primary: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 1,
                automaticallyImplyLeading: false,
                pinned: true,
                titleSpacing: 0,
                flexibleSpace: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ...?[
                        ['24小时排行', 1],
                        ['本周排行', 2],
                        ['本月排行', 3],
                      ].map((e) => FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            child: Text(
                              e[0],
                              style: TextStyle(
                                color: homeSalesModel.currentType == e[1]
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                            onPressed: () {
                              homeSalesModel.currentType = e[1];
//                              homeSalesModel.getListData(context);
                              refreshKey.currentState.callRefresh();
                            },
                          )),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) => buildCard(homeSalesModel.list[index],
                        index: index, context: context),
                    childCount: homeSalesModel.list.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
