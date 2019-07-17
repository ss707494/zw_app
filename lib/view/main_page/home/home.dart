import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/model/router.dart';
import 'package:zw_app/view/main_page/home/classifications/classifications.dart';
import 'package:zw_app/view/main_page/home/limited_time/limited_time.dart';

final shopNavList = [
  NavObj('分类选择', 'classifications', widget: Classifications()),
  NavObj('限时选购', 'limitedTime', widget: LimitedTime()),
  NavObj('热销排行', 'sales', widget: LimitedTime()),
  NavObj('主题甄选', 'subjectSelection', widget: LimitedTime()),
  NavObj('猜你喜欢', 'mayLike', widget: LimitedTime()),
//  NavObj('限时选购', 'limitedTime2', widget: LimitedTime()),
//  NavObj('限时选购', 'limitedTime3', widget: LimitedTime()),
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

//  @override
//  void deactivate() {
//    print('::::deactivate');
//    super.deactivate();
//  }

  @override
  Widget build(BuildContext context) {
    final routerModel = Provider.of<RouterModel>(context);
    return NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (context, boxIsScrolled) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CarouselSliderIndicator(
              items: [1, 2, 3, 4, 5]
                  .map((i) => Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          'https://images.pexels.com/photos/2553409/pexels-photo-2553409.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                          fit: BoxFit.fill,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          pinned: true,
          automaticallyImplyLeading: false,
          title: ButtonTheme(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 0,
            ),
            minWidth: 65,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: shopNavList.map((e) {
                bool isCurrent = e.routeName ==
                    (routerModel.getCurrent('shop') ??
                        shopNavList[0].routeName);
                return FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    pushNameByType(context, 'shop', e.routeName);
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
                );
              }).toList(),
            ),
          ),
        ),
      ],
      body: NestedNavigator(
        initialRoute: shopNavList[0].routeName,
        navigationKey: shopNavigationKey,
        routes: shopNavList.fold({}, (i, e) {
          return {
            ...i,
            e.routeName: e.widgetBuilder,
          };
        }),
      ),
    );
  }
}
