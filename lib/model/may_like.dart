import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/graphql_document/product_graphql.dart';
import 'package:zw_app/model/base_model.dart';

class MayLikeModel extends BaseModel {

  List<ProductItemEntity> _list;

  List<ProductItemEntity> get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }

  getList(context, {data}) async {
    QueryResult res = await graphqlQuery(context, getProductListWithFeatureDoc, data: data);
    _list = List<ProductItemEntity>()..addAll((res.data['product_list'] as List ?? []).map((e) => ProductItemEntity.fromJson(e)));
//    var res = await httpPost(context, getMayLikeListPath);
//    _list = res.data['data'] ?? [];
    handleInit();
    notifyListeners();
  }

}
