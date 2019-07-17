import 'package:flutter/material.dart';
import 'package:zw_app/model/provider_list.dart';

void main() => runApp(NestedScrollViewDemo());

class NestedScrollViewDemo extends StatefulWidget {
  _NestedScrollViewDemoState createState() => _NestedScrollViewDemoState();
}

class _NestedScrollViewDemoState extends State<NestedScrollViewDemo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderHelp(
      child: MaterialApp(
        home: Scaffold(
          body: NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    child: Center(
                      child: Text('box'),
                    ),
                  ),
                ),
                SliverAppBar(
                  centerTitle: true,
                  title: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('anniu1'),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text('anniu1'),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text('anniu1'),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text('anniu1'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  pinned: true,
                  floating: true,
                  forceElevated: boxIsScrolled,
                ),
              ];
            }, body: null,
//            body: NestedNavigator(
//              initialRoute: shopNavList[0].routeName,
//              navigationKey: shopNavigationKey,
//              routes: shopNavList.fold({}, (i, e) {
//                return {
//                  ...i,
//                  e.routeName: e.widgetBuilder,
//                };
//              }),
//            ),
          ),
        ),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('image1'),
        Text('image1'),
        Text('image2'),
      ],
    ));
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}
