import 'package:flutter/material.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';

final navList = [
  NavObj('分类选择', 'home'),
  NavObj('限时选购', 'home'),
  NavObj('分类选择', 'home'),
];

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Text('123123'),
            ),
            const SliverAppBar(
              elevation: 0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Demo'),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
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
        Row(
          children: <Widget>[
            ButtonBar(
              children: navList
                  .map((e) => FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, e.routeName);
                        },
                        child: Text(e.title),
                      ))
                  .toList(),
            )
          ],
        )
      ],
    );
  }
}
