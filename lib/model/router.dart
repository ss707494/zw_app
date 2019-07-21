import 'package:flutter/cupertino.dart';

class RouterModel extends ChangeNotifier {
//  var _homeCurrent = '';
//  var _shopCurrent = '';
  var currentRouterData = {
    'main': '',
    'home': '',
    'shop': '',
  };

  getCurrent(type) {
    return currentRouterData[type].isEmpty ? null : currentRouterData[type];
  }
  setCurrent(type, data) {
    currentRouterData[type] = data;
    if (type == 'home') {
      currentRouterData['shop'] = '';
    }
    notifyListeners();
  }

  // ScrollController
  ScrollController _scrollController;

  get scrollController => _scrollController;

  set scrollController(data) {
    _scrollController = data;
    notifyListeners();
    if (_scrollController == null) {
    }
  }
//  get homeCurrent => _homeCurrent;
//
//  set homeCurrent(data) {
//    _homeCurrent = data;
//    notifyListeners();
//  }
//
//  get shopCurrent => _shopCurrent;
//
//  set shopCurrent(data) {
//    _shopCurrent = data;
//    notifyListeners();
//  }
}
