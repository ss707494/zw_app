import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/address_item_entity.dart';
import 'package:zw_app/graphql_document/address.dart';

import 'confirm_order.dart';

class FormTextEditingController {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController contactInformation = TextEditingController();

  Map getFormData() {
    return {
      'name': name.text,
      'address': address.text,
      'province': province.text,
      'city': city.text,
      'district': district.text,
      'zip': zip.text,
      'contact_information': contactInformation.text,
    };
  }

  setFormData(AddressItemEntity item) {
    name.text = item?.name ?? '';
    address.text = item?.address ?? '';
    province.text = item?.province ?? '';
    city.text = item?.city ?? '';
    district.text = item?.district ?? '';
    zip.text = item?.zip ?? '';
    contactInformation.text = item?.contactInformation ?? '';
  }
}

class AddressModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  submit(context) async {
    if (!formKey.currentState.validate()) {
      _isAutoValidate = true;
      notifyListeners();
      return {};
    } else {
      QueryResult res = await graphqlQuery(context, saveAddressDoc, data: {
        'data': {
          ..._formTextEditingController.getFormData(),
          'id': editItem?.id,
        }
      });
      if (res.data['save_address']['flag'] == 1) {
        Fluttertoast.showToast(msg: '操作成功');
        return res.data['save_address'];
      }
    }
  }

  bool _isAutoValidate = false;

  bool get isAutoValidate => _isAutoValidate;

  set isAutoValidate(bool isAutoValidate) {
    _isAutoValidate = isAutoValidate;
    notifyListeners();
  }

  FormTextEditingController _formTextEditingController =
      FormTextEditingController();

  FormTextEditingController get formTextEditingController =>
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
    QueryResult res = await graphqlQuery(context, setDefaultAddress,
        data: {"defaultId": defaultId});
    if (res.data['set_default_address']['flag'] == 1) {
      Fluttertoast.showToast(msg: '操作成功');
    }
    return res.data['set_default_address'];
  }

  List<AddressItemEntity> _list = [];

  List<AddressItemEntity> get list => _list;

  set list(List<AddressItemEntity> list) {
    _list = list;
    notifyListeners();
  }

  getAddressById (String id) {
    return _list.firstWhere((e) => e.id == id, orElse: () => AddressItemEntity());
  }

  getListDataIfNull(context, {data}) async {
    if (_list.length == 0) {
      await getListData(context, data: data);
    }
  }

  getListData(context, {data}) async {
    QueryResult res =
        await graphqlQuery(context, getAddressList, data: {"data": data});
    _list = List<AddressItemEntity>()
      ..addAll((res.data['address_list'] as List ?? [])
          .map((e) => AddressItemEntity.fromJson(e)));
    _defaultId =
        _list?.firstWhere((e) => e.isDefault == 1, orElse: () => null)?.id ??
            '';
    if (_defaultId != '') {
      ConfirmOrderModel confirmOrderModel = Provider.of<ConfirmOrderModel>(context);
      confirmOrderModel.activeAddressId = _defaultId;
    }
    notifyListeners();
  }

  deleteItem(context, {id}) async {
    QueryResult res = await graphqlQuery(context, saveAddressDoc, data: {
      'data': {
        'id': id,
        'is_delete': 1,
      }
    });
    return res.data['save_address'];
  }

  AddressItemEntity _editItem;

  AddressItemEntity get editItem => _editItem;

  set editItem(AddressItemEntity editItem) {
    _editItem = editItem;
    notifyListeners();
  }

  setDetailItem(context, {AddressItemEntity item}) async {
    _editItem = item;
    _formTextEditingController.setFormData(item);
  }
}
