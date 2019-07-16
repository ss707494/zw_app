import 'package:flutter/material.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';

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
          elevation: 1,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text('分类选择'),
                )
              ],
            ),
          ),
        ),
        SliverList(
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
    );
  }
}
