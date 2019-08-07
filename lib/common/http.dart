library ss_dio;

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/http.dart';

var dio = Dio();

httpPost(context, path, {data}) async {
  final httpLoadingModel = Provider.of<HttpModel>(context, listen: false);
  Future.delayed(Duration.zero, () {
    httpLoadingModel.setCurrent(path, true);
  });
  FormData formData = new FormData.from(data ?? {});
  var res;
  res = await dio
      .post(
    '${httpLoadingModel.hostStr}$path',
    data: formData,
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
sslog: path: $path
sslog: data: $data
sslog: res: $res''';
  print(logInfo);
//  Flushbar(message: logInfo).show(context);
  return res;
}
