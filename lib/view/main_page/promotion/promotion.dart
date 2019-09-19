
import 'package:flutter/material.dart';
import 'package:zw_app/view/main_page/promotion/promo_code.dart';
import 'package:zw_app/view/main_page/promotion/promotion_card.dart';

class TabData {
  String title;
  Widget tabView;

  TabData({this.title, this.tabView});

}

List<TabData> tabDataList = [
  TabData(title: '我的达人卡(6)', tabView: PromotionCard()),
  TabData(title: '当前优惠促销(9)', tabView: PromoCode()),
];

class Promotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabDataList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('达人专区'),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.red,
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.black,
            tabs: tabDataList.map((e) => Tab(
              text: e.title,
            )).toList(),
          ),
        ),
        body: TabBarView(
          children: tabDataList.map((e) => e.tabView).toList(),
        ),
      ),
    );
  }
}
