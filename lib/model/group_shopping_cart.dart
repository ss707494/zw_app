import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/entity/shop_cart_item_entity.dart';
import 'package:zw_app/graphql_document/shopping_cart_graphql.dart';
import 'package:zw_app/model/base_model.dart';

enum ShipType { self, service }

class GroupShoppingCartModel extends BaseModel {
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

  List<ShopCartItemEntity> get productList =>
      _productList?.where((e) => e.isNext == 0)?.toList() ?? [];

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
      final con = TextEditingController(text: item.number.toString());
      con.addListener(() {
        notifyListeners();
      });
      _productNumbers[item.id] = con;
    }
  }

  getData(context) async {
    QueryResult res = await graphqlQuery(context, shopCartListDoc,
        fetchPolicy: FetchPolicy.cacheAndNetwork);
//    var res = await httpPost(context, getCartIndexInfo);
    initAllData();
    if (res == null) return;
    _data = res.data;
    _productList = List<ShopCartItemEntity>()
      ..addAll((res.data['shop_cart_list'] as List ?? [])
          .map((e) => ShopCartItemEntity.fromJson(e)));
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

//  List<ShopCartItemEntity> _nextProductList;

  List<ShopCartItemEntity> get nextProductList =>
      _productList?.where((e) => e.isNext != 0)?.toList() ?? [];

//  set nextProductList(v) {
//    _nextProductList = v;
//    notifyListeners();
//  }

  removeProductItem(context, ShopCartItemEntity item) async {
    _productList = _productList.where((e) => e != item).toList();
    QueryResult res =await graphqlQuery(context, removeShopCartDoc, data: {
      "id": item.id
    });
    if (res.data['flag'] == 0) {
      getData(context);
    }
    notifyListeners();
  }

  moveToNext(ShopCartItemEntity item) {
    item.isNext = 1;
//    _productList = _productList.where((e) => e != item).toList();
//    _nextProductList = [
//      item,
//      ..._nextProductList ?? [],
//    ];
    notifyListeners();
  }

  moveToProductList(ShopCartItemEntity item) {
    item.isNext = 0;
//    _nextProductList = _nextProductList.where((e) => e != item).toList();
//    _productList = [
//      item,
//      ..._productList ?? [],
//    ];
    addOneProductForNumber(item);
    notifyListeners();
  }

  getProductTotal() {
    return _productList == null || _productList.length == 0
        ? 0
        : _productList.fold(
            0,
            (pre, e) =>
                pre +
                    double.tryParse('${e.product.priceOut}') *
                        double.tryParse(_productNumbers[e.id] != null ? _productNumbers[e.id]?.text : '0') ??
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

  addToShopCart(context, {@required ProductItemEntity product}) async {
    _productList = [ShopCartItemEntity(
      number: _selectStar,
      productId: product.id,
      product: product,
      isNext: 0,
    )];
    if (_productNumbers == null) {
      _productNumbers = {};
    }
    _productNumbers[product.id] = _selectStar;

//    QueryResult res = await graphqlQuery(context, addToShopCartDoc, data: {
//      'data': {
//        'product_id': productId,
//      }
//    });
//    await getData(context);
//    if (res?.data['addToShopCart']['flag'] == 1) {
//      Fluttertoast.showToast(msg: '操作成功');
//    }
    return;
  }

  saveShopCart(context, {@required ShopCartItemEntity item}) async {
    int number = int.parse(_productNumbers[item.id].text);
    QueryResult res = await graphqlQuery(context, saveShopCartDoc, data: {
      "data": {
        "id": item.id,
        "number": number,
        "is_next": item.isNext
      }
    });
//    if (res?.data['addToShopCart']['flag'] == 1) {
//      Fluttertoast.showToast(msg: '操作成功');
//    }
    return res.data['flag'];
  }

  double _groupCopiesDiscount = 0.9;

  double get groupCopiesDiscount => _groupCopiesDiscount;

  set groupCopiesDiscount(double groupCopiesDiscount) {
    _groupCopiesDiscount = groupCopiesDiscount;
    notifyListeners();
  }

  double _groupFinishDiscount = 1;

  double get groupFinishDiscount => _groupFinishDiscount;

  set groupFinishDiscount(double groupFinishDiscount) {
    _groupFinishDiscount = groupFinishDiscount;
    notifyListeners();
  }

  int _selectStar = 0;

  int get selectStar => _selectStar;

  set selectStar(int selectStar) {
    _selectStar = selectStar;
    notifyListeners();
  }

  getUnitPrice(double priceOut) {
    return priceOut * _groupCopiesDiscount * _groupFinishDiscount;
  }

  initGroupData() {
    _selectStar = 0;
    _groupCopiesDiscount = 1.0;
    _groupFinishDiscount = 1.0;
  }

}
