import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/model/base_model.dart';

class UserCenterModel extends BaseModel {

  Map _userInfo;

  Map get userInfo => _userInfo ?? {};

  set userInfo(Map userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  getData(context) async {
    var res = await httpPost(context, getUserCenterInfo);
    var data = res.data['data'] ?? {};
    _userInfo = data['userInfo'];
    handleInit();
    notifyListeners();
  }

}
