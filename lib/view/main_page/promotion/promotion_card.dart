
import 'package:flutter/material.dart';

class PromotionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: List.generate(3, (index) => Card(
        margin: EdgeInsets.only(bottom: 16),
        child: Container(
          child: Center(child: Text('零食卡')),
          height: 170,
        ),
      )),
    );
  }
}
