import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/model/base_model.dart';

class SubjectSelectionModel extends BaseModel {

  var _list;

  get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }

  getList(context) async {
    var res = await httpPost(context, getMayLikeListPath);
    _list = res.data['data'] ?? [];
    handleInit();
    notifyListeners();
  }

}
