
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/model/http.dart';
import 'package:zw_app/model/user_center.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {

  bool showPassword = false;
  bool autoValidate = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserCenterModel userCenterModel = Provider.of<UserCenterModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码'),
      ),
      body: InitHasLoadingHelp(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              TextFormField(
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: '旧密码',
                ),
                controller: userCenterModel.oldPasswordController,
                validator: (v) => v == '' ? '必填项' : null,
                autovalidate: autoValidate,
              ),
              TextFormField(
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: '新密码',
                ),
                controller: userCenterModel.newPasswordController,
                validator: (v) => v == '' ? '必填项' : null,
                autovalidate: autoValidate,
              ),
              TextFormField(
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: '确认密码',
                ),
                controller: userCenterModel.confirmationPasswordController,
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
                      if (userCenterModel.newPasswordController.text != userCenterModel.confirmationPasswordController.text) {
                        Fluttertoast.showToast(msg: '两次密码输入不一致');
                      }
                      autoValidate = false;
                      var res = await userCenterModel.updatePassword(context);
                      if (res['flag'] == 1) {
                        userCenterModel.getData(context);
                        HttpModel httpModel = Provider.of<HttpModel>(context);
                        await httpModel.setTokenAsync(res['token']['token']);
                        await httpModel.setRefreshTokenAsync(res['token']['refreshtoken']);
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
