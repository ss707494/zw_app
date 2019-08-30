import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 1000),
        opacity: 0.7,
        child: Image.asset(
          'images/background_citric_citru.jpg',
          fit: BoxFit.fill,
        ),
      ),
      color: Colors.white,
    );
  }
}
