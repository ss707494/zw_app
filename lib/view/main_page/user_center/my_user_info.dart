import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/user_info_entity.dart';
import 'package:zw_app/model/user_center.dart';
import 'package:zw_app/view/main_page/user_center/edit_password.dart';
import 'package:zw_app/view/main_page/user_center/edit_user_info.dart';

class MyUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserCenterModel userCenterModel = Provider.of<UserCenterModel>(context);
    UserInfoEntity userInfo = userCenterModel.userInfo;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的达人证'),
        backgroundColor: Colors.white,
      ),
      body: InitHasLoadingHelp(
        init: () async {
          if (userInfo.id == null) {
            await userCenterModel.getData(context);
          }
        },
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: <Widget>[
                            Text('姓名'),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(userInfo.userName),
                            ),
                            Spacer(),
                            SizedBox(
                              height: 30,
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                      color: Colors.grey.withAlpha(100),
                                    )),
                                child: Text('编辑'),
                                onPressed: () {
                                  mainNavigationKey.currentState.push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditUserInfo()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: <Widget>[
                            Text('电话'),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(userInfo.phone),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: <Widget>[
                            Text('邮箱'),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(userInfo.email),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 8, color: Colors.grey.withAlpha(50)),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('账号设置',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('达人账号名'),
                  ),
                  Row(
                    children: <Widget>[
                      Text(userInfo.name),
                      Spacer(),
                      SizedBox(height: 47),
//                      FlatButton(
//                        child: Text('修改', style: TextStyle(color: Colors.red)),
//                        onPressed: () async {},
//                      ),
                    ],
                  ),
                  Container(height: 1, color: Colors.grey.withAlpha(30)),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('密码'),
                  ),
                  Row(
                    children: <Widget>[
                      Text('********'),
                      Spacer(),
                      FlatButton(
                        child: Text('修改', style: TextStyle(color: Colors.red)),
                        onPressed: () async {
                          mainNavigationKey.currentState.push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditPassword()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
