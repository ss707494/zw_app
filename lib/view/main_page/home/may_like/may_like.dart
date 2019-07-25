import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/component/loading_help/loading_help.dart';
import 'package:zw_app/model/may_like.dart';
import 'package:zw_app/view/main_page/home/classifications/component/product_card/product_card.dart';

class MayLike extends StatelessWidget {
  final ScrollController scrollViewController;

  const MayLike({Key key, this.scrollViewController}) : super(key: key);

  getData(context) async {
    final mayLikeModel = Provider.of<MayLikeModel>(context);
    if (mayLikeModel.list.length > 0) return;
    var res = await httpPost(context, getMayLikeListPath);
    mayLikeModel.list = res.data['data'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return InitHelp(
      init: () {
        getData(context);
      },
      child: LoadingHelp(
        path: getMayLikeListPath,
        child: Consumer<MayLikeModel>(
          builder: (_, mayLikeModel, __) => GridView.count(
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
      ),
    );
  }
}
