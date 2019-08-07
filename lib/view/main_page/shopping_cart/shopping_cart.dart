import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/confirm_dialog/confirm_dialog.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/model/shopping_cart.dart';

class ShoppingCart extends StatelessWidget {
  buildProductCard(context, item, ShoppingCartModel shoppingCartModel,
          {actionsWidgets}) =>
      Container(
        child: Container(
          height: 90,
          child: Row(
            children: <Widget>[
              Container(
                width: 90,
                height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageErrHelp(
                    imageUrl: item['imgUrl'],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(item['title']),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${item['weight']}${item['unit']}'),
                      ],
                    ),
                    Expanded(child: Text('${item['remark']}')),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '\$${item['originalPrice']}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '\$${item['sellPrice']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: actionsWidgets,
                        ),
//                      ...actionsWidgets,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  buildProductForCart(context, productList, ShoppingCartModel shoppingCartModel) =>
      List.generate(productList.length ?? 0, (index) {
        var item = productList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: buildProductCard(context, item, shoppingCartModel,
              actionsWidgets: [
                SizedBox(
                  height: 25,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey.withAlpha(100),
                    child: Text('下次再买'),
                    onPressed: () {
                      showConfirmDialog(
                        context: context,
                        content: Text('确认移动至下次购买'),
                        handleOk: () async {
                          shoppingCartModel.moveToNext(item);
                          return true;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      var control =
                          shoppingCartModel.productNumbers[item['id']];
                      if (control.text == '1') {
                        showConfirmDialog(
                          context: context,
                          content: Text('确认删除吗'),
                          handleOk: () async {
                            shoppingCartModel.removeProductItem(item);
                            return true;
                          },
                        );
                        return;
                      }
                      control.text = '${int.parse(control.text) - 1}';
                    },
                    icon: Icon(Icons.remove),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 25,
                  width: 45,
                  child: TextField(
                    controller: shoppingCartModel.productNumbers[item['id']],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2),
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      var control =
                          shoppingCartModel.productNumbers[item['id']];
                      control.text = '${int.parse(control.text) + 1}';
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ]),
        );
      });

  buildProductForNext(context, productList, ShoppingCartModel shoppingCartModel) =>
      List.generate(productList.length ?? 0, (index) {
        var item = productList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: buildProductCard(context, item, shoppingCartModel,
              actionsWidgets: [
                SizedBox(
                  height: 25,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey.withAlpha(100),
                    child: Text('删除', style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      showConfirmDialog(
                        context: context,
                        content: Text('确认删除吗'),
                        handleOk: () async {
                          shoppingCartModel.removeNextItem(item);
                        },
                      );
                    },
                  ),
                ),
                Container(width: 20),
                SizedBox(
                  height: 25,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey.withAlpha(100),
                    child: Text('加入购物车'),
                    onPressed: () {
                      showConfirmDialog(
                        context: context,
                        content: Text('确认加入购物车'),
                        handleOk: () async {
                          shoppingCartModel.moveToProductList(item);
                        },
                      );
                    },
                  ),
                ),
              ]),
        );
      });

  buildTitle(String text, {context}) => Padding(
        padding: const EdgeInsets.only(left: 10, top: 15),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ShoppingCartModel>(
          builder: (BuildContext context, shoppingCartModel, Widget child) {
            var products = shoppingCartModel.productList;
            return Column(
              children: <Widget>[
                Expanded(
                  child: EasyRefresh(
                    header: MaterialHeader(),
                    firstRefresh: true,
                    onRefresh: () async {
                      shoppingCartModel.getData(context);
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: <Widget>[
                        Center(
                          child: Text(
                            '${products.length}件商品',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text('小计: \$9.9'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: buildProductForCart(
                              context,
                              shoppingCartModel.productList,
                              shoppingCartModel,
                            ),
                          ),
                        ),
                        buildTitle('运送方式'),
                        Container(
                          height: 60,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RadioListTile(
                                  title: const Text('自取'),
                                  value: ShipType.self,
                                  groupValue: shoppingCartModel.shipType,
                                  onChanged: (value) {
                                    shoppingCartModel.shipType = value;
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  title: const Text('送货上门'),
                                  value: ShipType.service,
                                  groupValue: shoppingCartModel.shipType,
                                  onChanged: (value) {
                                    shoppingCartModel.shipType = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildTitle('达人卡和优惠券'),
                        Container(
                          height: 40,
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: CupertinoTextField(
                                  controller: shoppingCartModel.cardCodeController,
                                ),
                              ),
                              FlatButton(
                                child: Text(
                                    '${shoppingCartModel.isUseOffer ? '取消' : '使用'}'),
                                onPressed: () {},
                                color: Colors.grey.withAlpha(100),
                              ),
                            ],
                          ),
                        ),
                        buildTitle('预估价格'),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('小计'),
                                  Text('\$${shoppingCartModel.getProductTotal()}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('优惠券折扣'),
                                  Text('\$9.9'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('运费'),
                                  Text('\$9.9'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('总计'),
                                  Text('\$9.9'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        buildTitle('下次购买的商品(${shoppingCartModel.nextProductList?.length})'),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: buildProductForNext(
                              context,
                              shoppingCartModel.nextProductList,
                              shoppingCartModel,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: Colors.red,
                    onPressed: () {},
                    child: Text('结算', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
