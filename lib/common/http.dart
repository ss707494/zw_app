library ss_dio;

import 'package:dio/dio.dart';
//import 'package:flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/http.dart';

var dio = Dio();

httpPost(context, path, {data}) async {
  final httpLoadingModel = Provider.of<HttpModel>(context, listen: false);
  Future.delayed(Duration.zero, () {
    httpLoadingModel.setCurrent(path, true);
  });
  FormData formData = new FormData.from(data ?? {});
  final res = await dio
      .post(
    '${httpLoadingModel.hostStr}$path',
    data: formData,
  )
      .whenComplete(() {
    httpLoadingModel.setCurrent(path, false);
  });
//  await Future.delayed(Duration(seconds: 2));

  String logInfo = '''
sslog: path: $path
sslog: data: $data
sslog: res: $res''';
  print(logInfo);
//  Flushbar(message: logInfo).show(context);
  return res;
}
