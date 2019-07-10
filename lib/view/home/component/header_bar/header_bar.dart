import 'package:flutter/material.dart';
import 'package:zw_app/common/help_obj.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';

final navList = [
  NavObj('分类选择', 'home/classifications', 'home'),
  NavObj('限时选购', 'home/limitedTime', 'home'),
  NavObj('分类选择', 'home/classifications', 'home'),
];

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
              children: navList.map((e) => FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, e.routeName);
                },
                child: Text(e.title),
              )).toList(),
            )
          ],
        )
      ],
    );
  }
}
