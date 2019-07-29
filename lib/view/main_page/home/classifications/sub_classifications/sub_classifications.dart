import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/easy_refresh_cus/easy_refresh_cus.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';
import 'package:zw_app/model/sub_class.dart';
import 'package:zw_app/view/main_page/home/classifications/component/classification_card/classification_card.dart';
import 'package:zw_app/view/main_page/home/classifications/component/product_card/product_card.dart';

class SubClassifications extends StatelessWidget {
  final parentId;
  final int level;

  const SubClassifications({Key key, @required this.parentId, this.level = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TopSearch(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<SubClassModel>(
          builder: (_, subClassModel, __) {
            var data = level == 2
                ? subClassModel.subData2
                : subClassModel.subData3;
            data ??= {};
            return EasyRefreshCus(
              firstRefresh: true,
              onRefresh: () async {
                await Provider.of<SubClassModel>(context).getList(
                  context,
                  level: level,
                  data: {'ParentID': parentId},
                );
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ...data['CommodityTypeList']
                                ?.map((e) => ClassificationCard(
                                      item: e,
                                      level: level,
                                    ))
                                ?.toList() ??
                            [],
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '热门推荐',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverGrid.count(
                    childAspectRatio: 10 / 14,
                    crossAxisCount: 2,
                    children: [
                      ...data['CommodityList']
                              ?.map((e) => ProductCard(
                                    item: e,
                                  ))
                              ?.toList() ??
                          [],
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(height: 20),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
