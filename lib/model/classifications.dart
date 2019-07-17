import 'package:flutter/cupertino.dart';

class ClassificationsModel extends ChangeNotifier {

  List _list = [];

  get list => _list;

  set list(data) {
    _list = data;
    notifyListeners();
  }

}
