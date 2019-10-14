import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/graphql_document/order.dart';
import 'package:zw_app/graphql_document/shopping_cart_graphql.dart';
import 'package:zw_app/model/base_model.dart';
import 'package:zw_app/model/shopping_cart.dart';

class GroupConfirmOrderModel extends BaseModel {
  Map _allData = {};

  Map get allData => _allData;

  set allData(Map allData) {
    _allData = allData;
    notifyListeners();
  }

  getData(context) async {
//    var data = (await httpPost(context, getConfirmOrderInfo)).data['data'];
//    if (data == null) return;
//    _allData = data;
//    _addressList = data['addressList'];
//    if (_addressList.length > 0) {
//      _activeAddressId = _addressList[0]['id'];
//    }
//    _paymentTypeList = data['paymentTypeList'];
//    if (_paymentTypeList.length > 0) {
//      _activePaymentTypeId = _paymentTypeList[0]['id'];
//    }
//    _creditCoinsOver = double.parse('${data['creditCoinsOver']}');
    _creditCoinsController = TextEditingController(text: '');
    _creditCoinsController.addListener(() {
      notifyListeners();
    });
//    handleInit();
//    notifyListeners();
  }

  bool _isUseCreditCoins = false;

  bool get isUseCreditCoins => _isUseCreditCoins;

  set isUseCreditCoins(bool isUseCreditCoins) {
    _isUseCreditCoins = isUseCreditCoins;
    if (isUseCreditCoins) {
      _creditCoinsController.text = '0';
    }
    notifyListeners();
  }

  TextEditingController _creditCoinsController;

  TextEditingController get creditCoinsController => _creditCoinsController;

  set creditCoinsController(TextEditingController creditCoinsController) {
    _creditCoinsController = creditCoinsController;
    notifyListeners();
  }

  double getCreditCoinsDeduction() =>
      double.tryParse(_creditCoinsController?.text ?? '') ?? 0;

  double _creditCoinsOver = 0.0;

  double get creditCoinsOver => _creditCoinsOver;

  set creditCoinsOver(double creditCoinsOver) {
    _creditCoinsOver = creditCoinsOver;
    notifyListeners();
  }

  double _tax = 0.0;

  double get tax => _tax;

  set tax(double tax) {
    _tax = tax;
    notifyListeners();
  }

  String _activeAddressId;

  String get activeAddressId => _activeAddressId;

  set activeAddressId(String activeAddressId) {
    _activeAddressId = activeAddressId;
    notifyListeners();
  }

  String _activePaymentTypeId;

  String get activePaymentTypeId => _activePaymentTypeId;

  set activePaymentTypeId(String activePaymentTypeId) {
    _activePaymentTypeId = activePaymentTypeId;
    notifyListeners();
  }

  double get nextMonthCredit => 0;

  @override
  void dispose() {
    _creditCoinsController.dispose();
    super.dispose();
  }

  saveOrder(context) async {
    ShoppingCartModel shoppingCartModel = Provider.of<ShoppingCartModel>(context);
    GroupConfirmOrderModel confirmOrderModel = Provider.of<GroupConfirmOrderModel>(context);
    QueryResult res = await graphqlQuery(context, saveOrderDoc, data: {
      'data': {
        'actually_paid': shoppingCartModel.getFinalPrice() + confirmOrderModel.tax - confirmOrderModel.getCreditCoinsDeduction(),
        'address_id': activeAddressId,
        'coupon_discount': 0,
        'payment_method_card_id': activePaymentTypeId,
        'product': shoppingCartModel.productList.map((e) => {
          'product_id': e.productId,
          'count': double.tryParse(shoppingCartModel?.productNumbers[e.id]?.text) ?? 1,
        }).toList(),
        'sale_tax': tax,
        'state': 1,
        'subtotal': shoppingCartModel.getProductTotal(),
        'transportation_costs': shoppingCartModel.shipPrice,
        'vip_discount': confirmOrderModel.getCreditCoinsDeduction(),
      }
    });
    if (res.data['save_order']['flag'] == 1) {
      await graphqlQuery(context, removeAllShopCartDoc, data: {
        'ids': shoppingCartModel.productList.map((e) => e.id).toList(),
      });
      await shoppingCartModel.getData(context);
      Fluttertoast.showToast(msg: '操作成功');
    }
    return res.data['save_order'];
  }

}
