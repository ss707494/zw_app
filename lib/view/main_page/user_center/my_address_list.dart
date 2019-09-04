
import 'package:flutter/material.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';

class MyAddressList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的地址'),
      ),
      body: InitHasLoadingHelp(
        init: () async {},
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Container(
                width: 100,
                child: Row(
                  children: <Widget>[
                    Radio(
                      onChanged: (v) {},
                      value: '',
                      groupValue: '',
                    ),
                    ImageErrHelp(
                      imageUrl: '',
                    ),
                  ],
                ),
              ),
              title: Text('伤害'),
              subtitle: Text('静安'),
              trailing: FlatButton(
                child: Text('修改'),
                onPressed: () {},
              ),
            ),

          ],
        ),
      ),
    );
  }
}
