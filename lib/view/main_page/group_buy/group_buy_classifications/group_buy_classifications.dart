import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/easy_refresh_cus/easy_refresh_cus.dart';
import 'package:zw_app/model/classifications.dart';

import 'component/classification_card/classification_card.dart';

// classifications
class GroupBuyClassifications extends StatelessWidget {
  final ScrollController scrollViewController;

  GroupBuyClassifications({Key key, this.scrollViewController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classificationsModel = Provider.of<ClassificationsModel>(context);
    return EasyRefreshCus(
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
    );
  }
}
