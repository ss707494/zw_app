import 'package:flutter/cupertino.dart';

class RouterModel extends ChangeNotifier {

  var _homeCurrent = '';

  get homeCurrent => _homeCurrent;

  set homeCurrent(data) {
    print(data);
    _homeCurrent = data;
    notifyListeners();
  }

}
