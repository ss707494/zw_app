import 'package:flutter/material.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';
import 'package:zw_app/view/home/component/header_bar/header_bar.dart';

class Classifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: ListView(
        children: <Widget>[
          HeaderBar(),
        ],
      ),
    );
  }
}
