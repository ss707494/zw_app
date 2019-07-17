import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/model/classifications.dart';
import 'package:zw_app/model/http_loading.dart';
import 'package:zw_app/view/main_page/home/classifications/component/classification_card/classification_card.dart';

// classifications
class Classifications extends StatelessWidget {

  getData(classificationsModel, context) async {
    var res = await httpPost(context, getHomeDataPath);
    classificationsModel.list = res.data['data']['CommodityTypeList'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final classificationsModel = Provider.of<ClassificationsModel>(context);
    final httpLoadingModel = Provider.of<HttpLoadingModel>(context);
    return InitHelp(
      init: () {
        if (classificationsModel.list.length > 0) return;
        getData(classificationsModel, context);
      },
      child: Container(
        child: httpLoadingModel.getOne(getHomeDataPath)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  ...classificationsModel.list
                      ?.map(
                        (e) => ClassificationCard(
                          item: e,
                        ),
                      )
                      ?.toList(),
                ],
              ),
      ),
    );
  }
}
