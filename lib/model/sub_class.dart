import 'package:flutter/cupertino.dart';

class SubClassModel extends ChangeNotifier {

  var _subData2;
  var _subData3;

  get subData2 => _subData2;

  set subData2(data) {
    _subData2 = data;
    notifyListeners();
  }
  get subData3 => _subData3;

  set subData3(data) {
    _subData3 = data;
    notifyListeners();
  }

  List _list = [];

  get list => _list;

  set list(data) {
    _list = data;
    notifyListeners();
  }

}
