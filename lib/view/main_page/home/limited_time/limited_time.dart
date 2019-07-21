import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/component/loading_help/loading_help.dart';
import 'package:zw_app/model/may_like.dart';

class LimitedTime extends StatelessWidget {

  getData(context) async {
    final mayLikeModel = Provider.of<MayLikeModel>(context);
    if (mayLikeModel.list.length > 0) return;
    var res = await httpPost(context, getMayLikeListPath);
    mayLikeModel.list = res.data['data'] ?? [];
  }

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

  buildCard(item) => Card(
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
                    ...item['Picture']?.length != 0
                        ? item['Picture']
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
                            Text(item['F_CNameC']),
                            Container(
                              width: 10,
                            ),
                            Text('${item['F_CWeight']}${item['F_CPCompany']}'),
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
                            '当前剩余: 231',
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
                                '¥${item['F_CPUnitPriceMarket']}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '¥${item['F_CPUnitPriceOut']}',
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
    return InitHelp(
      init: () {
        getData(context);
      },
      child: LoadingHelp(
        path: getMayLikeListPath,
        child: Consumer<MayLikeModel>(
          builder: (_, mayLikeModel, __) => Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
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
                    ...?mayLikeModel.list.map(buildCard).toList(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
