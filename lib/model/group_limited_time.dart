import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/graphql_document/product_graphql.dart';
import 'package:zw_app/model/base_model.dart';

class GroupLimitedTimeModel extends BaseModel {

  List<ProductItemEntity> _list;

  List<ProductItemEntity> get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }

  getListData(context, {Map<String, dynamic> data}) async {
    QueryResult res = await graphqlQuery(context, getProductListWithFeatureDoc, data: {'data': {...?data, 'is_group': 1}});
    _list = List<ProductItemEntity>()..addAll((res.data['product_list'] as List ?? []).map((e) => ProductItemEntity.fromJson(e)));
    handleInit();
    notifyListeners();
  }

}
