library ss_dio;

import 'package:dio/dio.dart';

var dio = Dio();

final host = 'http://rap2api.taobao.org/app/mock/222495';

httpPost (path) {
  return dio.post('$host$path');
}
