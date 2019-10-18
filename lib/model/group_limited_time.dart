import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/group_queue_entity.dart';
import 'package:zw_app/graphql_document/group.dart';
import 'package:zw_app/model/base_model.dart';

class GroupLimitedTimeModel extends BaseModel {

  List<GroupQueueEntity> _list;

  List<GroupQueueEntity> get list => _list ?? [];

  set list(data) {
    _list = data;
    notifyListeners();
  }

  getListData(context, {Map<String, dynamic> data}) async {
    QueryResult res = await graphqlQuery(context, getGroupDetail);

//    QueryResult res = await graphqlQuery(context, getProductListWithFeatureDoc, data: {'data': {...?data, 'is_group': 1}});
    _list = List<GroupQueueEntity>()..addAll((res.data['group_queue_list'] as List ?? []).map((e) => GroupQueueEntity.fromJson(e)));
    handleInit();
    notifyListeners();
  }

}
