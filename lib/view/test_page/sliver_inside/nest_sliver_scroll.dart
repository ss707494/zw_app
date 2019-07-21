import 'package:flutter/material.dart';

void main() => runApp(NestSliverScroll());

var _tabs = ['123', '2323'];

class NestSliverScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DefaultTabController(
          length: _tabs.length, // This is the number of tabs.
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              // These are the slivers that show up in the "outer" scroll view.
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: SliverAppBar(
                    title: const Text('Books'),
                    // This is the title in the app bar.
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      // These are the widgets to put in each tab in the tab bar.
                      tabs:
                          _tabs.map((String name) => Tab(text: name)).toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: _tabs.map((String name) {
                return Container(
//                  top: false,
//                  bottom: false,
                  child: Builder(
                    // This Builder is needed to provide a BuildContext that is "inside"
                    // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                    // find the NestedScrollView.
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        // The "controller" and "primary" members should be left
                        // unset, so that the NestedScrollView can control this
                        // inner scroll view.
                        // If the "controller" property is set, then this scroll
                        // view will not be associated with the NestedScrollView.
                        // The PageStorageKey should be unique to this ScrollView;
                        // it allows the list to remember its scroll position when
                        // the tab view is not on the screen.
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverAppBar(
                            title: const Text('Books'),
                            pinned: true,
                            bottom: TabBar(
                              // These are the widgets to put in each tab in the tab bar.
                              tabs: ['', '']
                                  .map((String name) => Tab(text: name))
                                  .toList(),
                            ),
                          ),
//                          SliverToBoxAdapter(
//                            child: Container(
//                              height: 120,
//                              color: Colors.black54,
//                            ),
//                          ),
//                          SliverPersistentHeader(
//                            delegate: SliverPersistentHeaderDelegate(
//
//                            ),
//                          ),
                          SliverAppBar(
                              pinned: true,
                              title: Text('324234'),
                            ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            // In this example, the inner scroll view has
                            // fixed-height list items, hence the use of
                            // SliverFixedExtentList. However, one could use any
                            // sliver widget here, e.g. SliverList or SliverGrid.
                            sliver: SliverFixedExtentList(
                              // The items in this example are fixed to 48 pixels
                              // high. This matches the Material Design spec for
                              // ListTile widgets.
                              itemExtent: 48.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  return ListTile(
                                    title: Text('Item $index'),
                                  );
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
