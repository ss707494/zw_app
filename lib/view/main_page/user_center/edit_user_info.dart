
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/model/user_center.dart';

class EditUserInfo extends StatefulWidget {
  @override
  _EditUserInfoState createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {

  bool autoValidate = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserCenterModel userCenterModel = Provider.of<UserCenterModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('编辑用户信息'),
      ),
      body: InitHasLoadingHelp(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: '用户名',
                ),
                controller: userCenterModel.userNameController,
                validator: (v) => v == '' ? '必填项' : null,
                autovalidate: autoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '电话',
                ),
                controller: userCenterModel.phoneController,
                validator: (v) => v == '' ? '必填项' : null,
                autovalidate: autoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '邮箱',
                ),
                controller: userCenterModel.emailController,
                validator: (v) => v == '' ? '必填项' : null,
                autovalidate: autoValidate,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  color: Colors.red,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      autoValidate = false;
                      var res = await userCenterModel.updateUserInfo(context);
                      if (res['flag'] == 1) {
                        userCenterModel.getData(context);
                        mainNavigationKey.currentState.pop();
                      }
                    } else {
                      setState(() {
                        autoValidate = true;
                      });
                    }
                  },
                  child: Text(
                    '保存',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
