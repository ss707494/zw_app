import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/easy_refresh_cus/easy_refresh_cus.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/component/loading_help/loading_help.dart';
import 'package:zw_app/model/classifications.dart';
import 'package:zw_app/view/main_page/home/classifications/component/classification_card/classification_card.dart';

// classifications
class Classifications extends StatelessWidget {
  final ScrollController scrollViewController;

  const Classifications({Key key, this.scrollViewController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classificationsModel = Provider.of<ClassificationsModel>(context);
    return InitHelp(
      init: () {
//        if (classificationsModel.list.length > 0) return;
//        getData(classificationsModel, context);
//        classificationsModel.getListData(context);
      },
      child: LoadingHelp(
        path: null,
        child: EasyRefreshCus(
          firstRefresh: classificationsModel.isInit,
          onRefresh: () async {
            await classificationsModel.getListData(context);
          },
          outerController: scrollViewController,
          child: ListView.builder(
            itemCount: classificationsModel?.list?.length ?? 0,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) => ClassificationCard(
              item: classificationsModel.list[index],
              level: 1,
            ),
          ),
        ),
      ),
    );
  }
}
