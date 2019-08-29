import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql/client.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/entity/shop_cart_item_entity.dart';
import 'package:zw_app/graphql_document/shopping_cart_graphql.dart';
import 'package:zw_app/model/base_model.dart';

enum ShipType { self, service }

class ShoppingCartModel extends BaseModel {
  @override
  void dispose() {
    _productNumbers.forEach((key, e) {
      e.dispose();
    });
    _numberInputController.dispose();
    _cardCodeController.dispose();
    super.dispose();
  }

  var _data;

  List<ShopCartItemEntity> _productList;

  List<ShopCartItemEntity> get productList => _productList ?? [];

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

  addOneProductForNumber(ShopCartItemEntity item) {
    if (_productNumbers == null) {
      _productNumbers = {};
    }
    if (_productNumbers[item.id] == null) {
      final con = TextEditingController(text: '1');
      con.addListener(() {
        notifyListeners();
      });
      _productNumbers[item.id] = con;
    }
  }

  getData(context) async {
    QueryResult res = await graphqlQuery(context, shopCartListDoc);
//    var res = await httpPost(context, getCartIndexInfo);
    initAllData();
    if (res == null) return;
    _data = res.data;
    _productList = List<ShopCartItemEntity>()..addAll((res.data['shop_cart_list'] as List ?? []).map((e) => ShopCartItemEntity.fromJson(e)));
    _productList.forEach((e) {
      addOneProductForNumber(e);
    });
    handleInit();
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

  List<ShopCartItemEntity> _nextProductList;

  List<ShopCartItemEntity> get nextProductList => _nextProductList ?? [];

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
                    double.parse('${e.product.priceOut}') *
                        double.tryParse(_productNumbers[e.id].text) ??
                0);
  }

  TextEditingController _cardCodeController;

  get cardCodeController => _cardCodeController;

  initCardCodeController() {
    _cardCodeController = TextEditingController(text: '');
  }

  double _discountPrise = 0;

  double get discountPrise => _discountPrise ?? 0;

  set discountPrise(double discountPrise) {
    _discountPrise = discountPrise;
    notifyListeners();
  }

  checkCardCode(context) async {
    var data = (await httpPost(context, checkPromoCodePath,
            data: {'code': _cardCodeController.text}))
        .data['data'];
    if (data['checkState'] == 1) {
      _isUseOffer = true;
      _discountPrise = double.parse(data['discount'].toString());
    } else {
      _isUseOffer = false;
      _discountPrise = 0.0;
    }
    notifyListeners();
    return data;
  }

  cancelCardCode() {
    _cardCodeController.text = '';
    _isUseOffer = false;
    _discountPrise = 0.0;
    notifyListeners();
  }

  double _shipPrice = 0.0;

  double get shipPrice => _shipPrice;

  set shipPrice(double shipPrice) {
    _shipPrice = shipPrice;
    notifyListeners();
  }

  getFinalPrice() {
    return getProductTotal() - _discountPrise + _shipPrice;
  }

  TextEditingController _numberInputController = TextEditingController();

  TextEditingController get numberInputController => _numberInputController;

  addToShopCart(context, {@required String productId}) async {
    QueryResult res = await graphqlQuery(context, addToShopCartDoc, data: {
      'data': {
        'product_id': productId,
      }
    });
    await getData(context);
    if (res?.data['addToShopCart']['flag'] == 1) {
      Fluttertoast.showToast(msg: '操作成功');
    }
    return res?.data['addToShopCart'];
  }

}
