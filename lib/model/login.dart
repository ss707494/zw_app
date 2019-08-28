
import 'package:flutter/cupertino.dart';
import 'package:zw_app/common/http.dart';

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
    return await httpPost(context, 'api/login', data: {
      'name': _nameController.text,
      'password': _passwordController.text,
    });
  }

//  set nameController(TextEditingController nameController) {
//    _nameController = nameController;
//  }

}
