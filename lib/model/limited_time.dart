import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/model/base_model.dart';

class LimitedTimeModel extends BaseModel {

  var _list;

  get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }

  getListData(context, {data}) async {
    var res = await httpPost(context, getMayLikeListPath, data: data);
    _list = res.data['data'] ?? [];
    handleInit();
    notifyListeners();
  }

}
