import 'package:flutter/material.dart';
import 'package:zw_app/view/test_page/sliver_inside/sliver_fill_remaining_box_adapter.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text("AppBar"),
                floating: true,
                primary: true,
                pinned: false,
              ),
              SliverFillRemainingBoxAdapter(
                child: Container(
                  child: Column(
                    children: [1, 1, 1, 1, 1, 1, 1, 4, 5, 6]
                        .map((e) => Container(
                              height: 100,
                              child: Text('test$e'),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
