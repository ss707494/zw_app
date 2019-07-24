import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class UserCenter extends StatefulWidget {
  @override
  _UserCenter createState() => _UserCenter();
}

class _UserCenter extends State<UserCenter> {
  List<String> addStr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> str = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

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
    return Scaffold(
        appBar: AppBar(
          title: Text("Swiper"),
        ),
        body: EasyRefresh(
          key: _easyRefreshKey,
          onRefresh: () async {
            await new Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                str.clear();
                str.addAll(addStr);
              });
            });
          },
          loadMore: () async {
            await new Future.delayed(const Duration(seconds: 1), () {
              if (str.length < 20) {
                setState(() {
                  str.addAll(addStr);
                });
              }
            });
          },
          child: ListView.builder(
            itemBuilder: (context, index) => Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 2,
                    child: LinearProgressIndicator(),
                  ),
                  Container(
                    child: Text('$index'),
                  ),
                ],
              ),
            ),
          ),
//            child: NestedScrollView(
//              controller: _scrollViewController,
//              headerSliverBuilder: (context, boxIsScrolled) => [
//                SliverToBoxAdapter(
//                  child: Container(
//                    height: 50,
//                    color: Colors.grey,
//                  ),
//                ),
//              ],
//              body: Container(
//                child: ListView.builder(
//                  itemBuilder: (context, index) => Container(
//                    height: 200,
//                    child: Text('$index'),
//                  ),
//                ),
////                child: CustomScrollView(
////                  semanticChildCount: str.length,
////                  slivers: <Widget>[
////                    // 跑马灯
////                    SliverPadding(
////                      padding: EdgeInsets.all(0.0),
////                      sliver: SliverFixedExtentList(
////                          itemExtent: 150.0,
////                          delegate: SliverChildBuilderDelegate(
////                            (context, index) {
////                              return RefreshSafeArea(
////                                child: CarouselSlider(
////                                  height: 200,
////                                  items: List.generate(
////                                      3, (index) => _createMarqueeCard(index)),
////                                ),
////                              );
////                            },
////                            childCount: 1,
////                          )),
////                    ),
////                    SliverAppBar(
////                      pinned: true,
////                      flexibleSpace: Text('skdjfslkfdj'),
////                    ),
////                    SliverPadding(
////                      padding: EdgeInsets.all(0.0),
////                      sliver: SliverFixedExtentList(
////                          itemExtent: 70.0,
////                          delegate: SliverChildBuilderDelegate(
////                            (context, index) {
////                              return new Container(
////                                  height: 70.0,
////                                  child: Card(
////                                    child: new Center(
////                                      child: new Text(
////                                        str[index],
////                                        style: new TextStyle(fontSize: 18.0),
////                                      ),
////                                    ),
////                                  ));
////                            },
////                            childCount: str.length,
////                          )),
////                    )
////                  ],
////                ),
//              ),
//              // 手动维护semanticChildCount,用于判断是否没有更多数据
//            )
        ));
  }

}
