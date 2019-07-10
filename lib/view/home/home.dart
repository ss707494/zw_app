import 'package:flutter/material.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: ListView(
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
        ],
      ),
    );
  }
}
