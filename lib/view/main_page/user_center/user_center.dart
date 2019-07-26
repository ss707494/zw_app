import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zw_app/component/easy_refresh_cus/lib/easy_refresh.dart';
import 'package:zw_app/view/main_page/user_center/nested_scroll_view.dart' as prefix0;

class UserCenter extends StatefulWidget {
  @override
  _UserCenter createState() => _UserCenter();
}

final GlobalKey<EasyRefreshState> refreshKey = GlobalKey<EasyRefreshState>();

class _UserCenter extends State<UserCenter> {
  List<String> addStr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> str = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

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
//    final classificationsModel = Provider.of<LimitedTimeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Swiper"),
      ),
      body: prefix0.NestedScrollView(
          refreshWidgetBuild: ({child}) => EasyRefresh(
            key: refreshKey,
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
            },
            child: child,
          ),
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.grey,
            ),
          ),
          SliverAppBar(
            title: Text('333title'),
            pinned: true,
          ),
        ],
        body: Container(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, __) => Container(
              height: 100,
              color: Colors.grey,
              child: RaisedButton(
                onPressed: () {
                  refreshKey.currentState.callRefresh();
                },
                child: Text('refresh'),
              ),
            ),
          ),
        ),
//        slivers: <Widget>[
//          SliverFillRemaining(
//            child: Container(
//              child: Column(
//                children: List.generate(
//                    10,
//                    (index) => Container(
//                          height: 100,
//                          color: Colors.grey,
//                        )),
//              ),
//            ),
//          ),
////          SliverList(
////            delegate: SliverChildBuilderDelegate(
////                  (context, index) => Container(
////                height: 100,
////                color: Colors.grey,
////              ),
////              childCount: 10,
////            ),
////          ),
//        ],
      ),
    );
  }
}
