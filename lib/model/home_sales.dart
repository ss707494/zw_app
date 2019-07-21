import 'package:flutter/cupertino.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';

class HomeSalesModel extends ChangeNotifier {
  int _currentType;

  get currentType => _currentType ?? 1;
  set currentType(v) {
    _currentType = v;
    notifyListeners();
  }

  getListData(context, {params}) async {
    var res = await httpPost(context, getHomeSalesListPath);
    _list = res.data['data'] ?? [];
  }

  var _list;

  get list => _list;

  set list(data) {
    _list = data;
    notifyListeners();
  }
}
