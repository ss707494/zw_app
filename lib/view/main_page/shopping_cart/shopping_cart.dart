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
import 'package:zw_app/model/shopping_cart.dart';
import 'package:zw_app/view/main_page/shopping_cart/confirm_order.dart';

class ShoppingCart extends StatelessWidget {
  buildProductCard(context, ShopCartItemEntity item, ShoppingCartModel shoppingCartModel,
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
        ),
      );

  buildNumberInputDialog(context, id, ShoppingCartModel shoppingCartModel) {
    shoppingCartModel.numberInputController.text =
        shoppingCartModel.productNumbers[id].text;
    return SimpleDialog(
      title: Text('输入数量'),
      contentPadding: EdgeInsets.all(15),
      children: <Widget>[
        Form(
          child: TextFormField(
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            controller: shoppingCartModel.numberInputController,
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
            var num = shoppingCartModel.numberInputController.text;
            if (num.isEmpty || num == '0') {
              Fluttertoast.showToast(msg: '请输入数量');
              return;
            }
            shoppingCartModel.productNumbers[id].text =
                num.isNotEmpty ? num : '0';
            Navigator.of(context).pop();
          },
          child: Text('确认'),
        ),
      ],
    );
  }

  buildProductForCart(
          context, List<ShopCartItemEntity> productList, ShoppingCartModel shoppingCartModel) =>
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
                          shoppingCartModel.productNumbers[item.id];
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
                    readOnly: true,
                    controller: shoppingCartModel.productNumbers[item.id],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2),
                    ),
                    textAlign: TextAlign.center,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => buildNumberInputDialog(
                            context, item.id, shoppingCartModel),
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
                          shoppingCartModel.productNumbers[item.id];
                      control.text = '${int.parse(control.text) + 1}';
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ]),
        );
      });

  buildProductForNext(
          context, List<ShopCartItemEntity> productList, ShoppingCartModel shoppingCartModel) =>
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
            List<ShopCartItemEntity> products = shoppingCartModel.productList;
            return Column(
              children: <Widget>[
                Expanded(
                  child: EasyRefresh(
                    header: MaterialHeader(),
                    firstRefresh: shoppingCartModel.isInit,
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
                          builder: (context) => ConfirmOrder()));
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
