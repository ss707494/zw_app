import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/address_item_entity.dart';
import 'package:zw_app/entity/pay_card_entity.dart';
import 'package:zw_app/graphql_document/order.dart';
import 'package:zw_app/model/address.dart';
import 'package:zw_app/model/group_confirm_order.dart';
import 'package:zw_app/model/group_shopping_cart.dart';
import 'package:zw_app/model/pay_card.dart';

class GroupConfirmOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GroupConfirmOrderModel confirmOrderModel = Provider.of<GroupConfirmOrderModel>(context);
    GroupShoppingCartModel shoppingCartModel = Provider.of<GroupShoppingCartModel>(context);
    AddressModel addressModel = Provider.of<AddressModel>(context);
    PayCardModel payCardModel = Provider.of<PayCardModel>(context);

    blobText(text) => Text(text, style: TextStyle(fontWeight: FontWeight.bold));

    Widget addressChose(context) {
      var confirmOrderModel = Provider.of<GroupConfirmOrderModel>(context);
      return SimpleDialog(
        title: Text('地址选择'),
        children: <Widget>[
          Column(
            children: List.generate(addressModel.list.length, (index) {
              AddressItemEntity item = addressModel.list[index];
              return RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(item.address),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Text(item.contactUserName),
                          Text(item.contactInformation),
                        ],
                      ),
                    ),
                  ],
                ),
                groupValue: confirmOrderModel.activeAddressId,
                value: item.id,
                onChanged: (v) {
                  confirmOrderModel.activeAddressId = v;
                  Navigator.of(context).pop();
                },
              );
            }),
          ),
        ],
      );
    }

    AddressItemEntity activeAddress =
        addressModel.getAddressById(confirmOrderModel.activeAddressId);
    addressBox() => Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              blobText(
                shoppingCartModel.shipType == ShipType.self ? '自取地址' : '送货地址',
              ),
              Container(height: 10),
              addressModel.list.length == 0
                  ? Container(
                      child: Text('请先添加地址'),
                    )
                  : activeAddress.id == null
                      ? Container(
                          child: FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => addressChose(context));
                            },
                            child: Text('请选择地址'),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  activeAddress.address ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Container(height: 6),
                                Row(
                                  children: <Widget>[
                                    Text(activeAddress.contactUserName ?? '',
                                        style: TextStyle(color: Colors.grey)),
                                    Text(activeAddress.contactInformation ?? '',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        addressChose(context));
                              },
                            ),
                          ],
                        ),
            ],
          ),
        );

    Widget paymentTypeChose(context) {
      var confirmOrderModel = Provider.of<GroupConfirmOrderModel>(context);
      return SimpleDialog(
        title: Text('支付方式选择'),
        children: [
          Column(
            children: List.generate(payCardModel.list.length, (index) {
              PayCardEntity item = payCardModel.list[index];
              return RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(item.addressDetail),
                    Text(item.number),
                  ],
                ),
                groupValue: confirmOrderModel.activePaymentTypeId,
                value: item.id,
                onChanged: (v) {
                  confirmOrderModel.activePaymentTypeId = v;
                  Navigator.of(context).pop();
                },
              );
            }),
          ),
        ],
      );
    }

    PayCardEntity activePayCard =
        payCardModel.getPayCardById(confirmOrderModel.activePaymentTypeId);
    Widget paymentType = Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          blobText('付款方式'),
          Container(height: 10),
          payCardModel.list.length == 0
              ? Container(
                  child: Text('请先添加付款方式'),
                )
              : activePayCard.id == null
                  ? Container(
                      child: FlatButton(
                        onPressed: () {
                          showDialog(
                            builder: (context) => paymentTypeChose(context),
                            context: context,
                          );
                        },
                        child: Text('请选择付款方式'),
                      ),
                    )
                  : Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ImageErrHelp(
                              imageUrl: '',
                            ),
                          ),
                        ),
                        Container(width: 9),
                        Column(
                          children: [
                            Text(
                              activePayCard.userName ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(activePayCard.number ?? ''),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => paymentTypeChose(context),
                            );
                          },
                        ),
                      ],
                    ),
        ],
      ),
    );

    Widget creditCoins = Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              blobText('达人币'),
              Container(width: 10),
              Text('当月可用余额:'),
              Container(width: 3),
              Text(
                '\$${confirmOrderModel.creditCoinsOver}',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              Spacer(),
              Switch(
                value: confirmOrderModel.isUseCreditCoins,
                onChanged: (v) => confirmOrderModel.isUseCreditCoins = v,
              ),
            ],
          ),
          !confirmOrderModel.isUseCreditCoins
              ? Container()
              : Container(
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.grey.withAlpha(50),
                  child: TextField(
                    readOnly: true,
                    controller: confirmOrderModel.creditCoinsController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      border: InputBorder.none,
                      prefixText: '\$',
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                                contentPadding: EdgeInsets.all(15),
                                title: Text('修改使用数量'),
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text('当月可用余额:'),
                                      Text(
                                        '\$${confirmOrderModel.creditCoinsOver}',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller:
                                        confirmOrderModel.creditCoinsController,
                                    decoration: InputDecoration(
                                      prefixText: '\$',
                                    ),
                                  ),
                                  FlatButton(
                                    child: Text('确认'),
                                    onPressed: () {
                                      var num = double.tryParse(
                                          confirmOrderModel
                                              .creditCoinsController.text);
                                      if (num == null ||
                                          num < 0 ||
                                          num >
                                              confirmOrderModel
                                                  .creditCoinsOver) {
                                        Fluttertoast.showToast(msg: '请输入正确数量');
                                        return;
                                      }
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    },
                  ),
                ),
        ],
      ),
    );

    Widget segmentation = Container(
      height: 8,
      color: Colors.grey.withAlpha(50),
    );

    Widget amount = Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('购物车总计'),
              Spacer(),
              Text('\$${shoppingCartModel.getFinalPrice() ?? 0}'),
            ],
          ),
          Row(
            children: <Widget>[
              Text('达人币抵扣'),
              Spacer(),
              Text('-\$${confirmOrderModel.getCreditCoinsDeduction()}',
                  style: TextStyle(color: Colors.red)),
            ],
          ),
          Row(
            children: <Widget>[
              Text('消费税'),
              Spacer(),
              Text('\$${confirmOrderModel.tax}'),
            ],
          ),
          Container(
            height: 2,
            color: Colors.grey.withAlpha(20),
          ),
          Row(
            children: <Widget>[
              Text('订单总额',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Spacer(),
              Text(
                  '\$${shoppingCartModel.getFinalPrice() + confirmOrderModel.tax - confirmOrderModel.getCreditCoinsDeduction()}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          Row(
            children: <Widget>[
              Text('提交订单则表示同意'),
              Text('《用户购买协议》'),
            ],
          ),
        ],
      ),
    );

    TextStyle redTextStyle = TextStyle(
      color: Colors.red,
      fontSize: 14,
    );
    Widget submit = Container(
      child: Column(
        children: <Widget>[
          Container(height: 100),
          Container(height: 2, color: Colors.grey.withAlpha(50)),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('本次订单', style: redTextStyle),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          color: Colors.grey.withAlpha(50),
                          child: Text(
                            '白银达人',
                            style: TextStyle(
                              color: Colors.black.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('将获得下月使用达人币', style: redTextStyle),
                        Text('\$${confirmOrderModel.nextMonthCredit}',
                            style: redTextStyle.apply(fontSizeDelta: 4))
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: 150,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '提交订单',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      var res = await confirmOrderModel.saveOrder(context);
                      if (res['order'] != null) {
                        mainNavigationKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => Container()));
                      }
                    },
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('确认订单'),
      ),
      body: InitHasLoadingHelp(
        path: saveOrderDoc,
        init: /*!confirmOrderModel.isInit ? null : */ () async {
          await confirmOrderModel.getData(context);
          await addressModel.getListDataIfNull(context);
          await payCardModel.getListDataIfNull(context);
        },
        child: ListView(
          children: <Widget>[
            addressBox(),
            segmentation,
            paymentType,
            segmentation,
            creditCoins,
            segmentation,
            amount,
            submit,
          ],
        ),
      ),
    );
  }
}
