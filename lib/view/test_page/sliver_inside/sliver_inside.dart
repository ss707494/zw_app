import 'package:flutter/material.dart';

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
    Color tabColor = Theme.of(context).primaryColorDark;
    TextStyle tabStyle = TextStyle(color: tabColor);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("AppBar"),
              floating: true,
              primary: true,
              pinned: false,
            ),
            SliverFillRemaining(
              child: Scaffold(
                appBar: TabBar(
                  controller: tabController,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Tab1',
                        style: tabStyle,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Tab2',
                        style: tabStyle,
                      ),
                    ),
                  ],
                ),
                body: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    Scaffold(
                      body: Text('Tab One'),
                    ),
                    Scaffold(
                      body: Text('Tab Two'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
