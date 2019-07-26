import 'package:flutter/cupertino.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';

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

  getList(context, {data, level = 2}) async {
    if (level == 2) {
      _subData2 = {};
    }
    if (level == 3) {
      _subData3 = {};
    }
//    notifyListeners();
    var res = await httpPost(
      context,
      getSubClassPath,
      data: data,
    );
    if (level == 2) {
      _subData2 = res.data['data'] ?? {};
    }
    if (level == 3) {
      _subData3 = res.data['data'] ?? {};
    }
    notifyListeners();
  }

}
