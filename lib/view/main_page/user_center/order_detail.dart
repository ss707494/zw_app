import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';

class OrderDetail extends StatelessWidget {
  final String id;

  const OrderDetail({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
      ),
      body: InitHasLoadingHelp(
        init: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: Text('2lk3j232lk3j'),
      ),
    );
  }
}
