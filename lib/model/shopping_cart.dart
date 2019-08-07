import 'package:flutter/cupertino.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';

enum ShipType { self, service }

class ShoppingCartModel extends ChangeNotifier {
  var _data;

  List _productList;

  List get productList => _productList ?? [];

  set productList(v) {
    _productList = v;
    notifyListeners();
  }

  get data => _data ?? {};

  set data(data) {
    _data = data;
    notifyListeners();
  }

  initAllData() {
    initCardCodeController();
  }

  addOneProductForNumber(item) {
    if (_productNumbers == null) {
      _productNumbers = {};
    }
    if (_productNumbers[item['id']] == null) {
      final con = TextEditingController(text: '1');
      con.addListener(() {
        notifyListeners();
      });
      _productNumbers[item['id']] = con;
    }
  }

  getData(context) async {
    var res = await httpPost(context, getCartIndexInfo);
    initAllData();
    if (res == null) return;
    _data = res.data['data'] ?? {};
    _productList = res.data['data']['productList'] ?? [];
    _productList.forEach((e) {
      addOneProductForNumber(e);
    });
    notifyListeners();
  }

  var _shipType;

  get shipType => _shipType ?? ShipType.self;

  set shipType(v) {
    _shipType = v;
    notifyListeners();
  }

  Map _productNumbers = {};

  get productNumbers => _productNumbers ?? {};

  set productNumbers(v) {}

  bool _isUseOffer;

  get isUseOffer => _isUseOffer ?? false;

  set isUseOffer(v) {
    _isUseOffer = v;
    notifyListeners();
  }

  List _nextProductList;

  get nextProductList => _nextProductList ?? [];

  set nextProductList(v) {
    _nextProductList = v;
    notifyListeners();
  }

  removeProductItem(item) {
    _productList = _productList.where((e) => e != item).toList();
    notifyListeners();
  }

  moveToNext(item) {
    _productList = _productList.where((e) => e != item).toList();
    _nextProductList = [
      item,
      ..._nextProductList ?? [],
    ];
    notifyListeners();
  }

  moveToProductList(item) {
    _nextProductList = _nextProductList.where((e) => e != item).toList();
    _productList = [
      item,
      ..._productList ?? [],
    ];
    addOneProductForNumber(item);
    notifyListeners();
  }

  removeNextItem(item) {
    _nextProductList = _nextProductList.where((e) => e != item).toList();
    notifyListeners();
  }

  getProductTotal() {
    return _productList == null
        ? 0
        : _productList.fold(
            0,
            (pre, e) =>
                pre +
                double.parse('${e['sellPrice']}') *
                    double.parse(_productNumbers[e['id']].text));
  }

  TextEditingController _cardCodeController;
  get cardCodeController => _cardCodeController;
  initCardCodeController() {
    _cardCodeController = TextEditingController(text: '');
  }

  checkCardCode(context) async {
    await httpPost(context, checkPromoCode);
  }

  @override
  void dispose() {
    _productNumbers.forEach((key, e) {
      e.dispose();
    });
    super.dispose();
  }
}
