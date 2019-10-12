import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/easy_refresh_cus/easy_refresh_cus.dart';
import 'package:zw_app/model/group_product.dart';
import 'package:zw_app/view/main_page/group_buy/group_buy_classifications/component/product_card/product_card.dart';

import 'filter_draw.dart';
import 'order_draw.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class ProductList extends StatelessWidget {
  final title;
  final typeId;

  const ProductList({Key key, this.title, this.typeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<GroupProductModel>(context);
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(title ?? ''),
        leading: BackButton(),
        actions: [Container()],
      ),
      endDrawer: Drawer(
        child: FilterDraw(),
      ),
      drawer: Drawer(
        child: OrderDraw(),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 1,
            color: Colors.grey.withAlpha(150),
          ),
          SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                  FlatButton(
                    child: Text('排序'),
                    onPressed: () {
                      _scaffoldState.currentState.openDrawer();
                    },
                    padding: EdgeInsets.all(0),
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Text('筛选'),
                    onPressed: () {
                      _scaffoldState.currentState.openEndDrawer();
                    },
                  ),
                ],
            ),
          ),
          Expanded(
            child: EasyRefreshCus(
              firstRefresh: true,
              onRefresh: () async {
                await productModel.getListData(
                  context,
                  data: {
                    "data": {
                      "category_id": typeId
                    }
                  },
                );
              },
              child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 10),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 10 / 14,
                crossAxisCount: 2,
                children: <Widget>[
                  ...productModel
                      .getList()
                      .map((e) => ProductCard(
                    item: e,
                  ))
                      .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
