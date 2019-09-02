
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/common/router_help.dart';

import 'http.dart';

class LoginModel extends ChangeNotifier {
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  set showPassword(bool showPassword) {
    _showPassword = showPassword;
    notifyListeners();
  }

  TextEditingController _nameController = TextEditingController();

  TextEditingController get nameController => _nameController;

  TextEditingController _passwordController = TextEditingController();

  TextEditingController get passwordController => _passwordController;

  Future login (context) async {
    Response loginRes = await httpPost(context, 'api/login', data: {
      'name': _nameController.text,
      'password': _passwordController.text,
    });
    var res = loginRes.data;
    if (res['data'] == 1) {
      HttpModel httpModel = Provider.of<HttpModel>(context);
      await httpModel.setTokenAsync(res['token']);
      await httpModel.setRefreshTokenAsync(res['refreshtoken']);
      mainNavigationKey.currentState.pushNamedAndRemoveUntil('main', (r) => false);
      _passwordController.text = '';
      _nameController.text = '';
    } else {
      Fluttertoast.showToast(msg: res['message'] ?? '登录出错');
    }
  }

  loginOut (context) async {
    HttpModel httpModel = Provider.of<HttpModel>(context);
    await httpModel.deleteToken();
    mainNavigationKey.currentState.pushNamedAndRemoveUntil('login', (r) => false);
  }
//  set nameController(TextEditingController nameController) {
//    _nameController = nameController;
//  }

}
