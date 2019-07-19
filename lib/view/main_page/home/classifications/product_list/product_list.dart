import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/component/loading_help/loading_help.dart';
import 'package:zw_app/model/product.dart';
import 'package:zw_app/view/main_page/home/classifications/component/product_card/product_card.dart';
import 'package:zw_app/view/main_page/home/classifications/product_list/filter_draw.dart';
import 'package:zw_app/view/main_page/home/classifications/product_list/order_draw.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class ProductList extends StatelessWidget {
  final title;
  final typeId;

  const ProductList({Key key, this.title, this.typeId}) : super(key: key);

  getData(ProductModel model, context) async {
    var res = await httpPost(
      context,
      getProductListPath,
      data: {'F_CTID': typeId},
    );
    model.setList(res.data['data']);
  }

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return InitHelp(
      init: () {
        getData(productModel, context);
      },
      child: Scaffold(
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
            ButtonTheme(
              layoutBehavior: ButtonBarLayoutBehavior.constrained,
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Text('排序'),
                    onPressed: () {
                      _scaffoldState.currentState.openDrawer();
                    },
                  ),
                  FlatButton(
                    child: Text('筛选'),
                    onPressed: () {
                      _scaffoldState.currentState.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: LoadingHelp(
                path: getProductListPath,
                child: GridView.count(
                  childAspectRatio: 10 / 14,
                  crossAxisCount: 2,
                  children: <Widget>[
                    ...productModel
                        .getList()
                        .map((e) => ProductCard(
                      item: e,
                    ))
                        .toList(),
                    ...productModel
                        .getList()
                        .map((e) => ProductCard(
                      item: e,
                    ))
                        .toList(),
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
      ),
    );
  }
}
