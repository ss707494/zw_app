import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';

import 'base_model.dart';

class HomeSalesModel extends BaseModel {
  int _currentType;

  get currentType => _currentType ?? 1;
  set currentType(v) {
    _currentType = v;
    notifyListeners();
  }

  getListData(context, {params}) async {
    handleInit();
    var res = await httpPost(context, getHomeSalesListPath, data: params);
    _list = res.data['data'] ?? [];
    notifyListeners();
  }

  var _list;

  get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }
}
