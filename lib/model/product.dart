import 'package:flutter/cupertino.dart';

enum ProductOrderType {
  e,
  discount,
  volume,
  isNew,
  priceHigh,
  priceLow,
}

class ProductModel extends ChangeNotifier {
  List _list;

  ProductOrderType _order;

  ProductOrderType get order => _order ?? ProductOrderType.discount;

  set order(ProductOrderType v) {
    _order = v;
    notifyListeners();
  }

  getList() => _list ?? [];

  setList(data) {
    _list = data;
    notifyListeners();
  }

  List _choseBrand = [];

  addChoseBrand(v) {
    _choseBrand.add(v);
    notifyListeners();
  }
  removeChoseBrand(v) {
    _choseBrand.removeWhere((e) => e == v);
    notifyListeners();
  }

  get choseBrand => _choseBrand ?? [];

  set choseBrand(v) {
    _choseBrand = v;
    notifyListeners();
  }

  List _choseDiscount = [];

  addChoseDiscount(v) {
    _choseDiscount.add(v);
    notifyListeners();
  }
  removeChoseDiscount(v) {
    _choseDiscount.removeWhere((e) => e == v);
    notifyListeners();
  }

  get choseDiscount => _choseDiscount ?? [];

  set choseDiscount(v) {
    _choseDiscount = v;
    notifyListeners();
  }

}
