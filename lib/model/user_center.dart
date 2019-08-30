import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/user_coin_entity.dart';
import 'package:zw_app/entity/user_info_entity.dart';
import 'package:zw_app/graphql_document/user.dart';
import 'package:zw_app/model/base_model.dart';

class UserCenterModel extends BaseModel {

  UserCoinEntity _userCoin;

  UserCoinEntity get userCoin => _userCoin ?? UserCoinEntity();

  set userCoin(UserCoinEntity userCoin) {
    _userCoin = userCoin;
    notifyListeners();
  }

  UserInfoEntity _userInfo;

  UserInfoEntity get userInfo => _userInfo ?? UserInfoEntity();

  set userInfo(UserInfoEntity userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  List _orderList;

  List get orderList => _orderList ?? [];

  set orderList(List orderList) {
    _orderList = orderList;
    notifyListeners();
  }

  getData(context) async {
    QueryResult res = await graphqlQuery(context, getUserCenterDataDoc);
//    var res = await httpPost(context, getUserCenterInfo);
    var data = res.data ?? {};
    _userInfo = UserInfoEntity.fromJson(data['user_info']);
    _userCoin = UserCoinEntity.fromJson(data['user_coin']);
    _orderList = data['order_list'];
    handleInit();
    notifyListeners();
  }

}
