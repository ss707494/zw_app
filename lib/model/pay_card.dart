import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/pay_card_entity.dart';
import 'package:zw_app/graphql_document/pay_card.dart';

import 'confirm_order.dart';

class PayCardFormTextEditingController {
  TextEditingController userName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController addressDetail = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController contact = TextEditingController();

  Map getFormData() {
    return {
      'user_name': userName.text,
      'number': number.text,
      'code': code.text,
      'address_detail': addressDetail.text,
      'zip_code': zipCode.text,
      'city': city.text,
      'contact': contact.text,
    };
  }

  setFormData(PayCardEntity item) {
    userName.text = item?.userName ?? '';
    number.text = item?.number ?? '';
    code.text = item?.code ?? '';
    addressDetail.text = item?.addressDetail ?? '';
    zipCode.text = item?.zipCode ?? '';
    city.text = item?.city ?? '';
    contact.text = item?.contact ?? '';
  }
}

class PayCardModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  submit(context) async {
    if (!formKey.currentState.validate()) {
      _isAutoValidate = true;
      notifyListeners();
      return {};
    } else {
      QueryResult res = await graphqlQuery(context, savePayCardDoc, data: {
        'data': {
          ..._formTextEditingController.getFormData(),
          'id': editItem?.id,
        }
      });
      if (res.data['save_pay_card']['flag'] == 1) {
        Fluttertoast.showToast(msg: '操作成功');
        return res.data['save_pay_card'];
      }
    }
  }

  bool _isAutoValidate = false;

  bool get isAutoValidate => _isAutoValidate;

  set isAutoValidate(bool isAutoValidate) {
    _isAutoValidate = isAutoValidate;
    notifyListeners();
  }

  PayCardFormTextEditingController _formTextEditingController =
  PayCardFormTextEditingController();

  PayCardFormTextEditingController get formTextEditingController =>
      _formTextEditingController;

//  set formTextEditingController(FormTextEditingController formTextEditingController) {
//    _formTextEditingController = formTextEditingController;
//    notifyListeners();
//  }

  String _defaultId;

  String get defaultId => _defaultId;

  set defaultId(String defaultId) {
    _defaultId = defaultId;
    notifyListeners();
  }

  setDefaultId(context, String defaultId) async {
    QueryResult res = await graphqlQuery(context, setDefaultPayCard,
        data: {"defaultId": defaultId});
    if (res.data['set_default_pay_card']['flag'] == 1) {
      Fluttertoast.showToast(msg: '操作成功');
    }
    return res.data['set_default_pay_card'];
  }

  List<PayCardEntity> _list = [];

  List<PayCardEntity> get list => _list;

  set list(List<PayCardEntity> list) {
    _list = list;
    notifyListeners();
  }

  getPayCardById (String id) {
    return _list.firstWhere((e) => e.id == id, orElse: () => PayCardEntity());
  }

  getListDataIfNull(context, {data}) {
    if (_list.length == 0) {
      getListData(context, data: data);
    }
  }

  getListData(context, {data}) async {
    QueryResult res =
        await graphqlQuery(context, getPayCardList, data: {"data": data});
    _list = List<PayCardEntity>()
      ..addAll((res.data['pay_card_list'] as List ?? [])
          .map((e) => PayCardEntity.fromJson(e)));
    _defaultId =
        _list?.firstWhere((e) => e.isDefault == 1, orElse: () => null)?.id ??
            '';
    if (_defaultId != '') {
      ConfirmOrderModel confirmOrderModel = Provider.of<ConfirmOrderModel>(context);
      confirmOrderModel.activePaymentTypeId = _defaultId;
    }
    notifyListeners();
  }

  deleteItem(context, {id}) async {
    QueryResult res = await graphqlQuery(context, savePayCardDoc, data: {
      'data': {
        'id': id,
        'is_delete': 1,
      }
    });
    return res.data['save_pay_card'];
  }

  PayCardEntity _editItem;

  PayCardEntity get editItem => _editItem;

  set editItem(PayCardEntity editItem) {
    _editItem = editItem;
    notifyListeners();
  }

  setDetailItem(context, {PayCardEntity item}) async {
    _editItem = item;
    _formTextEditingController.setFormData(item);
  }
}
