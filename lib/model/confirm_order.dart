import 'package:flutter/cupertino.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';

class ConfirmOrderModel extends ChangeNotifier {
  Map _allData = {};

  Map get allData => _allData;

  set allData(Map allData) {
    _allData = allData;
    notifyListeners();
  }

  getData(context) async {
    var data = (await httpPost(context, getConfirmOrderInfo)).data['data'];
    if (data == null) return;
    _allData = data;
    _addressList = data['addressList'];
    if (_addressList.length > 0) {
      _activeAddressId = _addressList[0]['id'];
    }
    _paymentTypeList = data['paymentTypeList'];
    if (_paymentTypeList.length > 0) {
      _activePaymentTypeId = _paymentTypeList[0]['id'];
    }
    _creditCoinsOver = double.parse('${data['creditCoinsOver']}');
    _creditCoinsController = TextEditingController(text: '');
    _creditCoinsController.addListener(() {
      notifyListeners();
    });

    notifyListeners();
  }

  List _addressList = [];

  List get addressList => _addressList;

  set addressList(List addressList) {
    _addressList = addressList;
    notifyListeners();
  }

  List _paymentTypeList = [];

  List get paymentTypeList => _paymentTypeList;

  set paymentTypeList(List paymentTypeList) {
    _paymentTypeList = paymentTypeList;
    notifyListeners();
  }

  bool _isUseCreditCoins = false;

  bool get isUseCreditCoins => _isUseCreditCoins;

  set isUseCreditCoins(bool isUseCreditCoins) {
    _isUseCreditCoins = isUseCreditCoins;
    _creditCoinsController.text = '';
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

  get finalPrice => (double.tryParse('${_allData['totalCartAmount']}') ?? 0) + _tax - getCreditCoinsDeduction();

  String _activeAddressId;

  String get activeAddressId => _activeAddressId;

  set activeAddressId(String activeAddressId) {
    _activeAddressId = activeAddressId;
    notifyListeners();
  }

  get activeAddress {
    return addressList.firstWhere((e) => e['id'] == _activeAddressId);
  }

  String _activePaymentTypeId;

  String get activePaymentTypeId => _activePaymentTypeId;

  set activePaymentTypeId(String activePaymentTypeId) {
    _activePaymentTypeId = activePaymentTypeId;
    notifyListeners();
  }


  get activePaymentType {
    if (_activePaymentTypeId.isEmpty) return {};
    return paymentTypeList.firstWhere((e) => e['id'] == _activePaymentTypeId);
  }

  double get nextMonthCredit => 0;

}
