
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql/client.dart';
import 'package:zw_app/common/graphql_client.dart';
import 'package:zw_app/entity/address_item_entity.dart';
import 'package:zw_app/graphql_document/address.dart';

class FormTextEditingController {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController contactInformation = TextEditingController();

  getFormData () {
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

}

class AddressModel extends ChangeNotifier {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  submit (context) async {
    if (!formKey.currentState.validate()) {
      _isAutoValidate = true;
      notifyListeners();
      return {};
    } else {
      QueryResult res = await graphqlQuery(context, saveAddressDoc, data: {'data': _formTextEditingController.getFormData()});
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

  FormTextEditingController _formTextEditingController = FormTextEditingController();

  FormTextEditingController get formTextEditingController => _formTextEditingController;

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
    QueryResult res = await graphqlQuery(context, setDefaultAddress, data: {
      "defaultId": defaultId
    });
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

  getListData (context, {data}) async {
    QueryResult res = await graphqlQuery(context, getAddressList, data: {
      "data": data
    });
    _list = List<AddressItemEntity>()..addAll((res.data['address_list'] as List ?? []).map((e) => AddressItemEntity.fromJson(e)));
    _defaultId = _list?.firstWhere((e) => e.isDefault == 1, orElse: () => null)?.id ?? '';
    notifyListeners();
  }

}

