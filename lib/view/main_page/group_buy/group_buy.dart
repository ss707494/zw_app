import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/component/sliver_app_bar_height/sliver_app_bar_height.dart';
import 'package:zw_app/model/router.dart';

import 'group_buy_classifications/group_buy_classifications.dart';
import 'group_buy_home_sales/group_buy_home_sales.dart';
import 'group_buy_limited_time/group_buy_limited_time.dart';

var getShopNavList = (control) => [
      NavObj('冲线排行', 'limitedTime',
          widget: GroupBuyLimitedTime(scrollViewController: control)),
      NavObj('热门排行', 'sales',
          widget: GroupBuyHomeSales(scrollViewController: control)),
      NavObj('分类拼团', 'classifications',
          widget: GroupBuyClassifications(scrollViewController: control)),
    ];

class GroupBuy extends StatefulWidget {
  @override
  _GroupBuyState createState() => _GroupBuyState();
}

class _GroupBuyState extends State<GroupBuy> {
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routerModel = Provider.of<RouterModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TopSearch(),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              bottom: 2,
            ),
            child: Row(
              children: <Widget>[
                Text('热搜:'),
                Text('乐事薯片'),
                Text('牛奶'),
              ],
            ),
          ),
          Expanded(
            child: Container(
                child: NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder: (context, boxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: CarouselSliderIndicator(
                      items: List.generate(
                          3,
                          (i) => Container(
                                width: double.infinity,
                                child: ImageErrHelp(
                                  imageUrl: [
                                        'https://images.pexels.com/photos/1029609/pexels-photo-1029609.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                                        'https://images.pexels.com/photos/2356089/pexels-photo-2356089.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                        'https://images.pexels.com/photos/2553409/pexels-photo-2553409.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260'
                                      ][i] ??
                                      'https://images.pexels.com/photos/2553409/pexels-photo-2553409.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                                ),
                              )),
                    ),
                  ),
                ),
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: SliverAppBarHeight(
                    customizeHeight: 45,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 1,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            getShopNavList(_scrollViewController).map((e) {
                          bool isCurrent = e.routeName ==
                              (routerModel.getCurrent('groupBuy') ??
                                  getShopNavList(_scrollViewController)[0]
                                      .routeName);
                          return SizedBox(
                            width: 75,
                            height: 45,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                pushNameByType(
                                    context, 'groupBuy', e.routeName);
//                    _scrollViewController.jumpTo(0);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    e.title,
                                    style: isCurrent
                                        ? TextStyle(
                                            color: Colors.red[400],
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          )
                                        : null,
                                  ),
                                  isCurrent
                                      ? Container(
                                          margin: EdgeInsets.only(top: 4),
                                          height: 3,
                                          width: 44,
                                          color: Colors.red[400],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
              body: Container(
                margin: EdgeInsets.only(top: 44.0),
                child: NestedNavigator(
                  initialRoute:
                      getShopNavList(_scrollViewController)[0].routeName,
                  navigationKey: groupBuyNavigationKey,
                  routes:
                      getRouterByNavList(getShopNavList(_scrollViewController)),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
