
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/user_info_entity.dart';
import 'package:zw_app/model/user_center.dart';

class MyCredentials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserCenterModel userCenterModel = Provider.of<UserCenterModel>(context);
    UserInfoEntity userInfo = userCenterModel.userInfo;

    return SafeArea(
      child: InitHasLoadingHelp(
        init: () async {},
        child: ListView(
          children: <Widget>[
            Container(
              child: Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('姓名'),
                        Text(userInfo.userName),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
