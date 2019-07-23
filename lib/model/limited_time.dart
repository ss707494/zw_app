import 'package:flutter/cupertino.dart';

class LimitedTimeModel extends ChangeNotifier {

  var _list;

  get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }

}
