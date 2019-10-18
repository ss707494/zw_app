import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/order_item_entity.dart';
import 'package:zw_app/graphql_document/order.dart';
import 'package:zw_app/model/base_model.dart';

// 1:代付款 2:已付款 3:已发货 4:已收货 5:已取消 6:已完成 7:已退回
enum orderState {
  $,
  needPay,
  paid,
  Shipped,
  received,
  canceled,
  finished,
  returned,
}

getOrderStateByIndex(v) {
  var _help = {
    1: '代付款',
    2: '已付款',
    3: '已发货',
    4: '已收货',
    5: '已取消',
    6: '已完成',
    7: '已退回',
  };
  if (v is orderState) {
    return _help[v.index] ?? '';
  }
  if (v is int) {
    return _help[v] ?? '';
  }
  return '';
}

class OrderModel extends BaseModel {
  List<OrderItemEntity> _orderList = [];

  List<OrderItemEntity> get orderList => _orderList;

  set orderList(List<OrderItemEntity> orderList) {
    _orderList = orderList;
    notifyListeners();
  }

  List<OrderItemEntity> _groupOrderList = [];

  List<OrderItemEntity> get groupOrderList => _groupOrderList;

  set groupOrderList(List<OrderItemEntity> groupOrderList) {
    _groupOrderList = groupOrderList;
    notifyListeners();
  }

  getGroupData(context) async {
    QueryResult res = await graphqlQuery(context, getGroupOrderListDoc);
    _groupOrderList = List<OrderItemEntity>()
      ..addAll((res.data['group_order_list'] as List ?? [])
          .map((e) => OrderItemEntity.fromJson(e)));
    handleInit();
    notifyListeners();
  }

  getData(context) async {
    QueryResult res = await graphqlQuery(context, getOrderListDoc);
    _orderList = List<OrderItemEntity>()
      ..addAll((res.data['order_list'] as List ?? [])
          .map((e) => OrderItemEntity.fromJson(e)));
    handleInit();
    notifyListeners();
  }

  OrderItemEntity _orderDetail;

  OrderItemEntity get orderDetail => _orderDetail;

  set orderDetail(OrderItemEntity orderDetail) {
    _orderDetail = orderDetail;
    notifyListeners();
  }

  getOrderDetail(context, {@required String id, int isGroup}) async {

    QueryResult res = await graphqlQuery(context, getOrderDetailDoc,
        data: {'id': id, 'isGroup': isGroup});
    _orderDetail = OrderItemEntity.fromJson(res.data['order_detail'] ?? {});

    notifyListeners();
  }
}
