import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/confirm_dialog/confirm_dialog.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/entity/shop_cart_item_entity.dart';
import 'package:zw_app/model/http.dart';
import 'package:zw_app/model/group_shopping_cart.dart';

import 'group_confirm_order.dart';

class GroupShoppingCart extends StatefulWidget {
  @override
  _GroupShoppingCartState createState() => _GroupShoppingCartState();
}

class _GroupShoppingCartState extends State<GroupShoppingCart> {

  buildProductCard(context, ShopCartItemEntity item, GroupShoppingCartModel groupShoppingCartModel,
          {actionsWidgets}) =>
      Container(
        height: 90,
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ImageErrHelp(
                  imageUrl: item.product?.imgs == null ? '' : item.product?.imgs[0]?.url,
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
                      Text(item.product.name),
                      SizedBox(
                        width: 10,
                      ),
                      Text('${item.product.weight}${item.product.unit}'),
                    ],
                  ),
                  Expanded(child: Text('${item.product.remark}')),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '\$${item.product.priceMarket}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '\$${item.product.priceOut}',
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
      );

  buildNumberInputDialog(context, ShopCartItemEntity item, GroupShoppingCartModel groupShoppingCartModel) {
    groupShoppingCartModel.numberInputController.text =
        groupShoppingCartModel.productNumbers[item.id].text;
    return SimpleDialog(
      title: Text('输入数量'),
      contentPadding: EdgeInsets.all(15),
      children: <Widget>[
        Form(
          child: TextFormField(
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            controller: groupShoppingCartModel.numberInputController,
            autofocus: true,
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v.isEmpty) {
                return 'not empty';
              }
              return '';
            },
            autovalidate: true,
          ),
        ),
        FlatButton(
          onPressed: () {
            var num = groupShoppingCartModel.numberInputController.text;
            if (num.isEmpty || num == '0') {
              Fluttertoast.showToast(msg: '请输入数量');
              return;
            }
            groupShoppingCartModel.productNumbers[item.id].text =
                num.isNotEmpty ? num : '0';
            groupShoppingCartModel.saveShopCart(context, item: item);
            Navigator.of(context).pop();
          },
          child: Text('确认'),
        ),
      ],
    );
  }

  buildProductForCart(
          context, List<ShopCartItemEntity> productList, GroupShoppingCartModel groupShoppingCartModel) =>
      List.generate(productList.length ?? 0, (index) {
        var item = productList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: buildProductCard(context, item, groupShoppingCartModel,
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
                          groupShoppingCartModel.moveToNext(item);
                          groupShoppingCartModel.saveShopCart(context, item: item);
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
                          groupShoppingCartModel.productNumbers[item.id];
                      if (control.text == '1') {
                        showConfirmDialog(
                          context: context,
                          content: Text('确认删除吗'),
                          handleOk: () async {
                            groupShoppingCartModel.removeProductItem(context, item);
                            return true;
                          },
                        );
                        return;
                      }
                      control.text = '${int.parse(control.text) - 1}';
                      groupShoppingCartModel.saveShopCart(context, item: item);
                    },
                    icon: Icon(Icons.remove),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 25,
                  width: 45,
                  child: TextField(
                    readOnly: true,
                    controller: groupShoppingCartModel.productNumbers[item.id],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2),
                    ),
                    textAlign: TextAlign.center,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => buildNumberInputDialog(
                            context, item, groupShoppingCartModel),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      var control =
                          groupShoppingCartModel.productNumbers[item.id];
                      control.text = '${int.parse(control.text) + 1}';
                      groupShoppingCartModel.saveShopCart(context, item: item);
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ]),
        );
      });

  buildProductForNext(
          context, List<ShopCartItemEntity> productList, GroupShoppingCartModel groupShoppingCartModel) =>
      List.generate(productList.length ?? 0, (index) {
        var item = productList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: buildProductCard(context, item, groupShoppingCartModel,
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
                          groupShoppingCartModel.removeProductItem(context, item);
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
                          groupShoppingCartModel.moveToProductList(item);
                          groupShoppingCartModel.saveShopCart(context, item: item);
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
        body: Consumer<GroupShoppingCartModel>(
          builder: (BuildContext context, shoppingCartModel, Widget child) {
            List<ShopCartItemEntity> products = shoppingCartModel.productList;
            return Column(
              children: <Widget>[
                Expanded(
                  child: EasyRefresh(
                    header: MaterialHeader(),
                    firstRefresh: shoppingCartModel.isInit,
                    onRefresh: () async {
//                      shoppingCartModel.getData(context);
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
                          child: Text(
                              '小计: \$${shoppingCartModel.getProductTotal()}'),
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
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  color: Colors.grey.withAlpha(50),
                                  child: TextField(
                                    controller:
                                        shoppingCartModel.cardCodeController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 8),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Consumer<HttpModel>(
                                builder: (context, httpModel, _) => FlatButton(
                                  child: Text(
                                      '${shoppingCartModel.isUseOffer ? '取消' : '使用'}'),
                                  onPressed: httpModel
                                          .getOne(checkPromoCodePath)
                                      ? null
                                      : () async {
                                          if (shoppingCartModel
                                                  .cardCodeController.text ==
                                              '') {
                                            Fluttertoast.showToast(
                                                msg: '请输入优惠码');
                                            return;
                                          }
                                          if (shoppingCartModel.isUseOffer) {
                                            shoppingCartModel.cancelCardCode();
                                          } else {
                                            var data = await shoppingCartModel
                                                .checkCardCode(context);
                                            if (data['checkState'] != 1) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                        title: Center(
                                                            child: Text(
                                                                '达人卡和优惠券')),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.error_outline,
                                                            color: Colors.red,
                                                            size: 40,
                                                          ),
                                                          Container(height: 10),
                                                          Text('您输入的号码不正确或已过期'),
                                                          Text('请重新输入'),
                                                          SizedBox(height: 10),
                                                          FlatButton(
                                                            color: Colors.red,
                                                            child: Text(
                                                              '知道了',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      ));
                                            }
                                          }
                                        },
                                  color: Colors.grey.withAlpha(100),
                                ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('小计'),
                                  Text(
                                      '\$${shoppingCartModel.getProductTotal()}'),
                                ],
                              ),
                              shoppingCartModel.discountPrise > 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('优惠券折扣'),
                                        Text(
                                            '\$${shoppingCartModel.discountPrise}'),
                                      ],
                                    )
                                  : Container(),
                              shoppingCartModel.shipType == ShipType.self
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('运费'),
                                        Text(
                                            '\$${shoppingCartModel.shipPrice}'),
                                      ],
                                    ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('总计'),
                                  Text(
                                      '\$${shoppingCartModel.getFinalPrice()}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        buildTitle(
                            '下次购买的商品(${shoppingCartModel.nextProductList?.length})'),
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
                    onPressed: () {
                      if (shoppingCartModel.getFinalPrice() <= 0) {
                        return;
                      }
                      mainNavigationKey.currentState.push(MaterialPageRoute(
                          builder: (context) => GroupConfirmOrder()));
                    },
                    child: Text(
                      '共计 \$${shoppingCartModel.getFinalPrice()}, 去结算',
                      style: TextStyle(color: Colors.white),
                    ),
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
