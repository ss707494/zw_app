import 'package:flutter/material.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/nested_navigator/nested_navigator.dart';
import 'package:zw_app/view/main_page/home/classifications/classifications.dart';
import 'package:zw_app/view/main_page/home/limited_time/limited_time.dart';

final shopNavList = [
  NavObj('分类选择', 'classifications', widget: Classifications()),
  NavObj('限时选购', 'limitedTime', widget: LimitedTime()),
  NavObj('限时选购', 'limitedTime2', widget: LimitedTime()),
  NavObj('限时选购', 'limitedTime3', widget: LimitedTime()),
];

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
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
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: shopNavList
                  .map((e) => FlatButton(
                        onPressed: () {
                          shopPushName(context, e.routeName);
                        },
                        child: Text(e.title),
                      ))
                  .toList(),
            ),
          ),
        ),
        SliverFillRemaining(
          child: NestedNavigator(
              navigationKey: shopNavigationKey,
              initialRoute: shopNavList[0].routeName,
              routes: shopNavList.fold({}, (i, e) {
                return {
                  ...i,
                  e.routeName: e.widgetBuilder,
                };
              }),
            ),
        ),
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//            (BuildContext context, int index) {
//              return Container(
//                alignment: Alignment.center,
//                color: Colors.lightBlue[100 * (index % 9)],
//                child: Text('list item $index'),
//              );
//            },
//          ),
//        ),
      ],
    );
  }
}
