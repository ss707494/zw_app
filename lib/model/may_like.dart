import 'package:flutter/cupertino.dart';

class MayLikeModel extends ChangeNotifier {

  var _list;

  get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }

}
