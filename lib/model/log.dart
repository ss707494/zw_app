
import 'package:flutter/cupertino.dart';

class LogInfoModel extends ChangeNotifier {

  var _info;

  String get info => _info?.toString() ?? '';

  set info(data) {
    _info = data;
    notifyListeners();
  }

}
