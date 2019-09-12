

import 'package:flutter/material.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';

class PayCompleted extends StatelessWidget {

  final orderId;

  const PayCompleted({Key key, @required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      ),
      body: InitHasLoadingHelp(
        init: () async {
        },
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.done_outline),
                Column(
                  children: <Widget>[
                    Text('支付成功!'),
                    Text('感谢您的购买'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
