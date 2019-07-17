library ss_dio;

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/http_loading.dart';

var dio = Dio();

final host = 'http://rap2api.taobao.org/app/mock/222495';

httpPost(context, path, {data}) async {
  final httpLoadingModel = Provider.of<HttpLoadingModel>(context);
  httpLoadingModel.setCurrent(path, true);
  final res = await dio.post('$host$path').whenComplete(() {
    httpLoadingModel.setCurrent(path, false);
  });
  return res;
}
