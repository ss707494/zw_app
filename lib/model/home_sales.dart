import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/graphql_document/product_graphql.dart';

import 'base_model.dart';

class HomeSalesModel extends BaseModel {
  int _currentType;

  get currentType => _currentType ?? 1;

  set currentType(v) {
    _currentType = v;
    notifyListeners();
  }

  getListData(context, {Map<String, dynamic> data}) async {
    QueryResult res =
        await graphqlQuery(context, getProductListWithFeatureDoc, data: {'data': {...?data, 'is_group': 0}});
    _list = List<ProductItemEntity>()
      ..addAll((res.data['product_list'] as List ?? [])
          .map((e) => ProductItemEntity.fromJson(e)));
    handleInit();
    notifyListeners();
  }

  var _list;

  get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }
}
