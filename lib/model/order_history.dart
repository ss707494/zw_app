import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/model/base_model.dart';

class OrderHistoryModel extends BaseModel {

  List _orderList = [];

  List get orderList => _orderList;

  set orderList(List orderList) {
    _orderList = orderList;
    notifyListeners();
  }

  getData(context) async {
    var res = await httpPost(context, getUserOrderHistory);
    var data = res.data['data'] ?? {};
    _orderList = data['orderList'];
    handleInit();
    notifyListeners();
  }

}
