import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  TextEditingController _userNameController = TextEditingController();

  TextEditingController get userNameController => _userNameController;

  set userNameController(TextEditingController userNameController) {
    _userNameController = userNameController;
    notifyListeners();
  }

  TextEditingController _phoneController = TextEditingController();

  TextEditingController get phoneController => _phoneController;

  set phoneController(TextEditingController phoneController) {
    _phoneController = phoneController;
    notifyListeners();
  }

  TextEditingController _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController emailController) {
    _emailController = emailController;
    notifyListeners();
  }

  UserInfoEntity _userInfo;

  UserInfoEntity get userInfo => _userInfo ?? UserInfoEntity();

  set userInfo(UserInfoEntity userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  updateUserInfo (context) async {
    QueryResult res = await graphqlQuery(context, updateUserInfoDoc, data: {
      'data': {
        'name': _userNameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
      }
    });
    if (res.data['update_user_info']['flag'] == 1) {
      Fluttertoast.showToast(msg: '操作成功');
      _userNameController.clear();
      _phoneController.clear();
      _emailController.clear();
    }
    return res.data['update_user_info'];
  }

  List _orderList;

  List get orderList => _orderList ?? [];

  set orderList(List orderList) {
    _orderList = orderList;
    notifyListeners();
  }

  getData(context) async {
    QueryResult res = await graphqlQuery(context, getUserCenterDataDoc);
    var data = res.data ?? {};
    _userInfo = UserInfoEntity.fromJson(data['user_info']);
    _userCoin = UserCoinEntity.fromJson(data['user_coin']);
    _orderList = data['order_list'];
    _userNameController.text = _userInfo.userName;
    _phoneController.text = _userInfo.phone;
    _emailController.text = _userInfo.email;
    handleInit();
    notifyListeners();
  }

  TextEditingController _oldPasswordController = TextEditingController();

  TextEditingController get oldPasswordController => _oldPasswordController;

  TextEditingController _newPasswordController = TextEditingController();

  TextEditingController get newPasswordController => _newPasswordController;

  TextEditingController _confirmationPasswordController = TextEditingController();

  TextEditingController get confirmationPasswordController => _confirmationPasswordController;

  updatePassword (context) async {
    QueryResult res = await graphqlQuery(context, updatePasswordDoc, data: {
      'data': {
        'old_password': _oldPasswordController.text,
        'new_password': _newPasswordController.text,
      }
    });
    if (res?.data['update_password']['flag'] == 1) {
      Fluttertoast.showToast(msg: '操作成功');
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmationPasswordController.clear();
    }
    return res?.data['update_password'];
  }

}
