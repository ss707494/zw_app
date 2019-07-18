
import 'package:flutter/material.dart';
import 'package:zw_app/component/init_help/init_help.dart';

class ProductList extends StatelessWidget {
  final title;

  const ProductList({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitHelp(
      init: () {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? ''),
        ),
      ),
    );
  }
}
