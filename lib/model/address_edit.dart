
import 'package:flutter/cupertino.dart';

class AddressEditModel extends ChangeNotifier {

  FormTextEditingController _formTextEditingController = FormTextEditingController();

  FormTextEditingController get formTextEditingController => _formTextEditingController;

  set formTextEditingController(FormTextEditingController formTextEditingController) {
    _formTextEditingController = formTextEditingController;
    notifyListeners();
  }

}

class FormTextEditingController {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController contactInformation = TextEditingController();

}
