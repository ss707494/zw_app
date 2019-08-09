
import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier {
  bool _isInit = true;
  bool get isInit => _isInit;

  handleInit () {
    if (_isInit) {
      _isInit = false;
    }
//    notifyListeners();
  }
}
