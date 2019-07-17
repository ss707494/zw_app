import 'package:flutter/cupertino.dart';

class ClassificationsModel extends ChangeNotifier {

  bool _loading = false;
  List _list = [];

  get listLoading => _loading;
  set listLoading (v) {
    _loading = v;
    notifyListeners();
  }
  get list => _list;

  set list(data) {
    _list = data;
    notifyListeners();
  }

}
