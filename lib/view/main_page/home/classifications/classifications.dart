import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/model/classifications.dart';

// classifications
class Classifications extends StatelessWidget {
  getData(context) async {
//        var res = await httpPost('/App/WS_StyleSelect');
//    Response ss = await httpPost('/App/WS_StyleSelect');
//    print(ss);
//    Provider.of<LogInfoModel>(context).info = '323232323';
  }

  @override
  Widget build(BuildContext context) {
    final classificationsModel = Provider.of<ClassificationsModel>(context);
    return InitHelp(
      init: () async {
        classificationsModel.listLoading = true;
        var res = await httpPost('/App/WS_StyleSelect');
        classificationsModel.listLoading = false;
        classificationsModel.list = res.data['data']['CommodityTypeList'] ?? [];
      },
      child: Container(
        child: classificationsModel.listLoading ? Center(
          child: CircularProgressIndicator(),
        ) : Column(
          children: [
            Text('${classificationsModel.list.length}'),
            FlatButton(
              child: Text('add'),
              onPressed: () {
                getData(context);
              },
            ),

          ...classificationsModel.list
              ?.map((e) => Row(
            children: <Widget>[
              Image.network(e['Picture'] ?? ''),
              Text('${e['F_CTNameC']}'),
            ],
                  ))
              ?.toList(),
          ],
        ),
      ),
    );
  }
}
