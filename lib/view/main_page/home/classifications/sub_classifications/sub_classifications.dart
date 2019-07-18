import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/component/main_layout/main_layout.dart';
import 'package:zw_app/model/http_loading.dart';
import 'package:zw_app/model/sub_class.dart';
import 'package:zw_app/view/main_page/home/classifications/component/classification_card/classification_card.dart';
import 'package:zw_app/view/main_page/home/classifications/component/product_card/product_card.dart';

class SubClassifications extends StatelessWidget {
  final parentId;
  final int level;

  const SubClassifications({Key key, @required this.parentId, this.level = 2})
      : super(key: key);

  setData(SubClassModel model, data) {
    if (level == 2) {
      model.subData2 = data ?? {};
    }
    if (level == 3) {
      model.subData3 = data ?? {};
    }
  }

  getData(SubClassModel model, context) async {
    setData(model, {});
    var res = await httpPost(
      context,
      getSubClassPath,
      data: {'ParentID': parentId},
    );
    setData(model, res.data['data']);
  }

  @override
  Widget build(BuildContext context) {
    final subClassModel = Provider.of<SubClassModel>(context);
    final httpLoadingModel = Provider.of<HttpLoadingModel>(context);
    var data = level == 2 ? subClassModel.subData2 : subClassModel.subData3;
    data ??= {};
    return InitHelp(
      init: () {
        getData(subClassModel, context);
      },
      child: Scaffold(
        endDrawer: Drawer(
          child: Text('123123'),
        ),
        appBar: AppBar(
          elevation: 0,
          title: TopSearch(),
        ),
        body: httpLoadingModel.getOne(getSubClassPath)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                      childAspectRatio: 10/13,
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
                  ],
                ),
              ),
      ),
    );
  }
}
