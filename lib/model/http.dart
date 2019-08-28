import 'package:flutter/cupertino.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/common/secure_storage.dart';


class HttpModel extends ChangeNotifier {
  final List<String> _hostObj = [
    serverHost,
    'http://www.marketpayless.com',
  ];

  get hostObj => _hostObj;
  //final host = 'http://rap2api.taobao.org/app/mock/222495';
  int _host = 0;

  get host => _host;

  set host (v) {
    _host = v;
    notifyListeners();
  }

  get hostStr => _hostObj[_host];

  var loadingData = {};

  getOne(path) {
    return loadingData[path] ?? false;
  }

  setCurrent(path, data) {
    loadingData[path] = data;
    notifyListeners();
  }

  initToken () async {
    var __token = await getStorageByKey('token');
    var __refreshToken = await getStorageByKey('refreshtoken');
    _token = __token;
    _refreshToken = __refreshToken;
    print('sslog:: token:: $__token');
    print('sslog:: refreshToken:: $__refreshToken');
    notifyListeners();
  }

  String _token;

  String get token => _token;

  setTokenAsync(String token) async {
    _token = token;
    await setStorage(key: 'token', value: token);
    notifyListeners();
  }

  set token(String token) {
    _token = token;
    notifyListeners();
  }

  String _refreshToken;

  String get refreshToken => _refreshToken;

  setRefreshTokenAsync(String refreshToken) async {
    _refreshToken = refreshToken;
    await setStorage(key: 'refreshToken', value: refreshToken);
    notifyListeners();
  }

  set refreshToken(String refreshToken) {
    _refreshToken = refreshToken;
    notifyListeners();
  }

}
