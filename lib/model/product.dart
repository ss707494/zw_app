import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/graphql_document/product_graphql.dart';

enum ProductOrderType {
  e,
  discount,
  volume,
  isNew,
  priceHigh,
  priceLow,
}

class ProductModel extends ChangeNotifier {
  List<ProductItemEntity> _list;

  ProductOrderType _order;

  ProductOrderType get order => _order ?? ProductOrderType.discount;

  set order(ProductOrderType v) {
    _order = v;
    notifyListeners();
  }

  getListData(context, {data}) async {
    QueryResult res = await graphqlQuery(context, getProductListDoc, data: data);
    _list = List<ProductItemEntity>()..addAll((res.data['product_list'] as List ?? []).map((e) => ProductItemEntity.fromJson(e)));
//    _list = res.data['product_list'];
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
