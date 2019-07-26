import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/model/base_model.dart';

class ClassificationsModel extends BaseModel {

  List _list = [];
  var _popData = {};

  get popData => _popData;


  get list => _list;

  set list(data) {
    _list = data;
    notifyListeners();
  }
  getListData(context, {data}) async {
    var res = await httpPost(context, getHomeDataPath, data: data);
    _list = res.data['data']['CommodityTypeList'] ?? [];
    _popData = res.data['data'] ?? {};
    handleInit();
    notifyListeners();
  }

}
