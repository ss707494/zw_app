
import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  set showPassword(bool showPassword) {
    _showPassword = showPassword;
    notifyListeners();
  }

}
