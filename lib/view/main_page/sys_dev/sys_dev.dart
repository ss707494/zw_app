import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/easy_refresh_cus/lib/easy_refresh.dart';
import 'package:zw_app/model/http.dart';

class UserCenter extends StatefulWidget {
  @override
  _UserCenter createState() => _UserCenter();
}

final GlobalKey<EasyRefreshState> refreshKey = GlobalKey<EasyRefreshState>();

class _UserCenter extends State<UserCenter> {

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
      body: DropdownButtonFormField(
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
    );
  }
}
