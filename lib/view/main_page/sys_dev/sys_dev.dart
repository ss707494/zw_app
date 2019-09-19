import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/config.dart';
import 'package:zw_app/common/secure_storage.dart';
import 'package:zw_app/component/easy_refresh_cus/lib/easy_refresh.dart';
import 'package:zw_app/model/http.dart';

class SysDev extends StatefulWidget {
  @override
  _SysDev createState() => _SysDev();
}

final GlobalKey<EasyRefreshState> refreshKey = GlobalKey<EasyRefreshState>();

_dealIp(url) {
  return url.substring(url.indexOf('//') + 2, url.lastIndexOf(':'));
}

class _SysDev extends State<SysDev> {
  String token = '';
  String refreshToken = '';
  TextEditingController serverHostController =
      TextEditingController(text: _dealIp(serverHost));
  TextEditingController imgServerHostController =
      TextEditingController(text: _dealIp(imgServerHost));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final httpModel = Provider.of<HttpModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              ...helpServerList.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.grey.withOpacity(0.2),
                  child: Text(e),
                  onPressed: () {
                    serverHostController.text = e;
                  },
                ),
              )).toList(),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '服务器ip地址'),
            controller: serverHostController,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '服务器图片ip地址'),
            controller: imgServerHostController,
          ),
          RaisedButton(
            child: Text('修改ip地址'),
            onPressed: () {
              setServerHost(
                server: serverHostController.text,
                imgServer: imgServerHostController.text,
              );
            },
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(labelText: '接口地址'),
            value: httpModel.host,
            onChanged: (v) {
              httpModel.host = v;
            },
            items: List.generate(
              httpModel.hostObj.length,
              (index) => DropdownMenuItem(
                value: index,
                child: SizedBox(
                  width: 300,
                  child: Text(
                    httpModel.hostObj[index],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          Text(token),
          Text(refreshToken),
          FlatButton(
            child: Text('view token'),
            onPressed: () async {
              var _token = httpModel.token;
              var _refreshToken = httpModel.refreshToken;
              setState(() {
                token = _token;
                refreshToken = _refreshToken;
              });
            },
          ),
          FlatButton(
            child: Text('change token'),
            onPressed: () async {
              var _token = await getStorageByKey('token');
              var _refreshToken = await getStorageByKey('refreshtoken');
              setState(() {
                token = _token;
                refreshToken = _refreshToken;
              });
            },
          ),
          FlatButton(
            child: Text('change refreshToken'),
            onPressed: () async {
              var _token = await getStorageByKey('token');
              var _refreshToken = await getStorageByKey('refreshtoken');
              setState(() {
                token = _token;
                refreshToken = _refreshToken;
              });
            },
          ),
        ],
      ),
    );
  }
}
