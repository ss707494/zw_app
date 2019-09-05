
import 'package:flutter/material.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';

class EditAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('地址详情'),
        actions: <Widget>[
          FlatButton(
            child: Text('保存'),
            onPressed: () {},
          ),
        ],
      ),
      body: InitHasLoadingHelp(
        init: () async {Future.delayed(Duration(seconds: 1));},
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
