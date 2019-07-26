import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/easy_refresh_cus/easy_refresh_cus.dart';
import 'package:zw_app/model/may_like.dart';
import 'package:zw_app/view/main_page/home/classifications/component/product_card/product_card.dart';

class MayLike extends StatelessWidget {
  final ScrollController scrollViewController;

  const MayLike({Key key, this.scrollViewController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MayLikeModel>(
      builder: (_, mayLikeModel, __) => EasyRefreshCus(
        outerController: scrollViewController,
        firstRefresh: mayLikeModel.isInit,
        onRefresh: () async {
          await mayLikeModel.getList(context);
        },
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 10 / 14,
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              ...mayLikeModel.list
                  ?.map(
                    (e) => ProductCard(
                      item: e,
                    ),
                  )
                  ?.toList(),
            ]),
      ),
    );
  }
}
