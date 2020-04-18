import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/common/router_help.dart';

class RegisterModel extends ChangeNotifier {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController get confirmPasswordController => _confirmPasswordController;

  TextEditingController _userName = TextEditingController();

  TextEditingController get userName => _userName;

  TextEditingController _userPhone = TextEditingController();

  TextEditingController get userPhone => _userPhone;

  TextEditingController _userEmail = TextEditingController();

  TextEditingController get userEmail => _userEmail;

  Future submit(context) async {
    Response registerUserRes = await httpPost(context, 'api/registerUser', data: {
      'name': _nameController.text,
      'password': _passwordController.text,
      'userName': _userName.text,
      'userPhone': _userPhone.text,
      'userEmail': _userEmail.text,
    });
    if (registerUserRes.data['statusCode'] == 400) {
      Fluttertoast.showToast(msg: registerUserRes.data['statusMessage'] ?? '接口出错');
      return;
    }
    if (registerUserRes.data['data']['id'] != null) {
      Fluttertoast.showToast(msg: registerUserRes.data['statusMessage'] ?? '注册成功');
      mainNavigationKey.currentState.pop();
      return;
    }
  }

  loginOut(context) async {}

  void clearForm() {
    _nameController.clear();
    _passwordController.clear();
    _userName.clear();
    _userPhone.clear();
    _userEmail.clear();
  }
//  set nameController(TextEditingController nameController) {
//    _nameController = nameController;
//  }

}
