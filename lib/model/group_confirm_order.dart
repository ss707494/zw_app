import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/group_queue_entity.dart';
import 'package:zw_app/graphql_document/order.dart';
import 'package:zw_app/model/base_model.dart';

import 'group_shopping_cart.dart';

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
    GroupShoppingCartModel groupShoppingCartModel =
        Provider.of<GroupShoppingCartModel>(context);
    GroupQueueEntity selectGroupQueue = groupShoppingCartModel.groupQueueList
        .firstWhere((e) => e.selectAmount > 0, orElse: () => null);
    QueryResult res = await graphqlQuery(context, saveGroupOrderDoc, data: {
      'saveGroupOrderInput': {
        'product_id': groupShoppingCartModel.productList[0].productId,
        'group_queue_id': selectGroupQueue?.id,
        'order_group_amount': groupShoppingCartModel.selectStar,
        'origin_group_amount': selectGroupQueue.fillAmount,
      },
      'saveOrderInput': {
        'actually_paid': groupShoppingCartModel.getFinalPrice() +
            _tax -
            getCreditCoinsDeduction(),
        'address_id': activeAddressId,
        'coupon_discount': 0,
        'payment_method_card_id': activePaymentTypeId,
        'product': groupShoppingCartModel.productList
            .map((e) => {
                  'product_id': e.productId,
                  'count': double.tryParse(
                          groupShoppingCartModel?.productNumbers[e.id]?.text) ??
                      1,
                })
            .toList(),
        'sale_tax': tax,
        'state': 1,
        'subtotal': groupShoppingCartModel.getProductTotal(),
        'discount_product_total': groupShoppingCartModel.getDiscountProductTotal(),
        'transportation_costs': groupShoppingCartModel.shipPrice,
        'vip_discount': getCreditCoinsDeduction(),
      }
    });
    if (res.data['save_group_order']['flag'] == 1) {
//      await graphqlQuery(context, removeAllShopCartDoc, data: {
//        'ids': groupShoppingCartModel.productList.map((e) => e.id).toList(),
//      });
//      await groupShoppingCartModel.getData(context);
      Fluttertoast.showToast(msg: '操作成功');
    }
    return res.data['save_group_order'];
  }
}
