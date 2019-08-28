import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/category_list_entity.dart';
import 'package:zw_app/graphql_document/category_graphql.dart';
import 'package:zw_app/model/base_model.dart';

class ClassificationsModel extends BaseModel {

  List _list = [];
  var _popData = {};

  get popData => _popData;

  get list => _list;

  set list(data) {
    _list = data;
    notifyListeners();
  }

  getListData(context, {data}) async {
    QueryResult res = await graphqlQuery(context, getCategoryListDoc, data: {
      "data": {
        "parent_id": ''
      }
    });
    CategoryListEntity categoryListEntity = CategoryListEntity.fromJson(res.data ?? {});

    _list = categoryListEntity.categoryList ?? [];
//    var res = await httpPost(context, getHomeDataPath, data: data);
//    _list = res.data['data']['CommodityTypeList'] ?? [];
//    _popData = res.data['data'] ?? {};
    handleInit();
    notifyListeners();
  }
}
