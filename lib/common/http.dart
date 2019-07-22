library ss_dio;

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/http_loading.dart';

var dio = Dio();

//final host = 'http://rap2api.taobao.org/app/mock/222495';
final host = 'http://128.14.236.90:4433/mock/5d347e552b71b967c8c62b82/api';

httpPost(context, path, {data}) async {
  final httpLoadingModel = Provider.of<HttpLoadingModel>(context);
  Future.delayed(Duration.zero, () {
    httpLoadingModel.setCurrent(path, true);
  });
  final res = await dio.post('$host$path').whenComplete(() {
    httpLoadingModel.setCurrent(path, false);
  });
  return res;
}
