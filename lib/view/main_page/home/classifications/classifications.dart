import 'package:flutter/material.dart';

class Classifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [1, 2, 3, 4, 5, 4, 5, 4, 4, 4, 4, 4, 4, 4]
          .map((e) => Container(
                child: Text('123123$e'),
                height: 50,
              ))
          .toList(),
    );
  }
}
