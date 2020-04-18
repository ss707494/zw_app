
import 'package:zw_app/common/secure_storage.dart';

final isProd = bool.fromEnvironment('dart.vm.product');

List<String> helpServerList = [
  '10.0.2.2',
  '47.75.157.220',
];

String serverHost;
getServerHost() => serverHost;
//final String serverHost = 'http://47.75.157.220:4464/';
String imgServerHost;
getImgServerHost () => imgServerHost;

setServerHost ({String server, String imgServer}) async {
  if (server != null) {
    serverHost = server.contains('http') ? server : 'http://$server:4464/';
    await setStorage(key: 'serverHost', value: serverHost);
  }
  if (imgServer != null) {
    imgServerHost = imgServer.contains('http') ? imgServer : 'http://$imgServer:4464/';
    await setStorage(key: 'imgServerHost', value: imgServerHost);
  }
}

initConfig () async {
  String _serverHost = await getStorageByKey('serverHost');
  if (_serverHost == null || _serverHost == '') {
    _serverHost = 'http://${helpServerList[isProd ? 1 : 0]}:4464/';
    await setStorage(key: 'serverHost', value: _serverHost);
  }
  _serverHost.substring(_serverHost.indexOf('//') + 2, _serverHost.lastIndexOf(':'));
  serverHost = _serverHost;
  String _imgServerHost = await getStorageByKey('imgServerHost');
  if (_imgServerHost == null) {
    _imgServerHost = 'http://47.75.157.220:4464/';
    await setStorage(key: 'imgServerHost', value: _imgServerHost);
  }
  imgServerHost = _imgServerHost;
}
