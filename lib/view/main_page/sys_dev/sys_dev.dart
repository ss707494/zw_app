import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/secure_storage.dart';
import 'package:zw_app/component/easy_refresh_cus/lib/easy_refresh.dart';
import 'package:zw_app/model/http.dart';

class SysDev extends StatefulWidget {
  @override
  _SysDev createState() => _SysDev();
}

final GlobalKey<EasyRefreshState> refreshKey = GlobalKey<EasyRefreshState>();

class _SysDev extends State<SysDev> {
  String token = '';
  String refreshToken = '';

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
                )),
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
