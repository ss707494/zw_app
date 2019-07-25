import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zw_app/model/limited_time.dart';
import 'package:zw_app/view/main_page/home/classifications/component/classification_card/classification_card.dart';

class UserCenter extends StatefulWidget {
  @override
  _UserCenter createState() => _UserCenter();
}


class _UserCenter extends State<UserCenter> {
  List<String> addStr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> str = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();

  ScrollController _scrollViewController;
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _refreshController = RefreshController(initialRefresh: true);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final classificationsModel = Provider.of<LimitedTimeModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Swiper"),
        ),
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (_, __) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.grey,
                  height: 100,
                ),
              ),
              SliverAppBar(
                pinned: true,
                title: Text('2222'),
              ),
            ];
          },
          body: Container(
            child: EasyRefresh(
              firstRefresh: classificationsModel.isInit,
              outerController: _scrollViewController,
              refreshHeader:
                  BallPulseHeader(key: _headerKey),
              onRefresh: () async {
                  classificationsModel.getListData(context);
              },
//              loadMore: () async {
//              },
              child: ListView.builder(
                itemCount: classificationsModel?.list?.length ?? 0,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) => ClassificationCard(
                  item: classificationsModel.list[index],
                  level: 1,
                ),
              ),
            ),
          ),
        ));
  }
}
