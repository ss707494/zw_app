library ss_dio;

import 'package:dio/dio.dart';
//import 'package:flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/http_loading.dart';

var dio = Dio();

//final host = 'http://rap2api.taobao.org/app/mock/222495';
//final host = 'http://128.14.236.90:4433/mock/5d347e552b71b967c8c62b82/api';
final host = 'http://www.marketpayless.com';

httpPost(context, path, {data}) async {
  final httpLoadingModel = Provider.of<HttpLoadingModel>(context);
  Future.delayed(Duration.zero, () {
    httpLoadingModel.setCurrent(path, true);
  });
  FormData formData = new FormData.from(data ?? {});
  final res = await dio
      .post(
    '$host$path',
    data: formData,
  )
      .whenComplete(() {
    httpLoadingModel.setCurrent(path, false);
  });

  String logInfo = '''
sslog: path: $path
sslog: data: $data
sslog: res: $res''';
  print(logInfo);
//  Flushbar(message: logInfo).show(context);
  return res;
}
