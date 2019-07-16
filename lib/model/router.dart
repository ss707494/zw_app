import 'package:flutter/cupertino.dart';

class RouterModel extends ChangeNotifier {
  var _homeCurrent = '';
  var _shopCurrent = '';
  var currentRouterData = {
    'home': '',
    'shop': '',
  };

  getCurrent(type) {
    return currentRouterData[type];
  }
  setCurrent(type, data) {
    currentRouterData[type] = data;
    notifyListeners();
  }

  get homeCurrent => _homeCurrent;

  set homeCurrent(data) {
    _homeCurrent = data;
    notifyListeners();
  }

  get shopCurrent => _shopCurrent;

  set shopCurrent(data) {
    _shopCurrent = data;
    notifyListeners();
  }
}
