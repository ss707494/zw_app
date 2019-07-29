import 'package:flutter/cupertino.dart';


class HttpModel extends ChangeNotifier {
  final List<String> _hostObj = [
    'http://128.14.236.90:4433/mock/5d347e552b71b967c8c62b82/api',
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
}
