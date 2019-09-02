library ss_dio;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/http.dart';

var dio = Dio();

Future<Response> httpPost(context, String path, {data}) async {
  final httpLoadingModel = Provider.of<HttpModel>(context, listen: false);
  Future.delayed(Duration.zero, () {
    httpLoadingModel.setCurrent(path, true);
  });
//  FormData formData = new FormData.from(data ?? {});
  Response res;
  res = await dio
      .post(
    '${httpLoadingModel.hostStr}$path',
    data: data,
    options: Options(
      contentType: ContentType.json,
    )
  )
      .catchError((err) {
    print(err);
    Fluttertoast.showToast(msg: err.toString());
//    Flushbar(message: err).show(context);
  })
      .whenComplete(() {
    httpLoadingModel.setCurrent(path, false);
  });
  String logInfo = '''
sslog: path: ${httpLoadingModel.hostStr}$path
sslog: data: $data
sslog: res: $res''';
  print(logInfo);
//  Flushbar(message: logInfo).show(context);
  return res;
}
