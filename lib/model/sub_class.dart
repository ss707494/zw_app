import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/sub_category_with_product_entity.dart';
import 'package:zw_app/graphql_document/category_graphql.dart';

class SubClassModel extends ChangeNotifier {
  SubCategoryWithProductEntity _subData2;
  SubCategoryWithProductEntity _subData3;

  get subData2 => _subData2;

  set subData2(data) {
    _subData2 = data;
    notifyListeners();
  }

  get subData3 => _subData3;

  set subData3(data) {
    _subData3 = data;
    notifyListeners();
  }

  List _list = [];

  get list => _list;

  set list(data) {
    _list = data;
    notifyListeners();
  }

  getList(context, {data, level = 2}) async {
    if (level == 2) {
      _subData2 = SubCategoryWithProductEntity();
    }
    if (level == 3) {
      _subData3 = SubCategoryWithProductEntity();
    }
    QueryResult res = await graphqlQuery(context, getSubClassDoc, data: data);
    SubCategoryWithProductEntity subCategoryWithProductEntity =
    SubCategoryWithProductEntity.fromJson(res.data ?? {});
//    var res = await httpPost(
//      context,
//      getSubClassPath,
//      data: data,
//    );
    if (level == 2) {
      _subData2 = subCategoryWithProductEntity ?? {};
    }
    if (level == 3) {
      _subData3 = subCategoryWithProductEntity ?? {};
    }
    notifyListeners();
  }
}
