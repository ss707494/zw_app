import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/validator_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/model/address_edit.dart';

class EditAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddressEditModel addressEditModel = Provider.of<AddressEditModel>(context);
    FormTextEditingController formController =
        addressEditModel.formTextEditingController;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('地址详情'),
        actions: <Widget>[
          FlatButton(
            child: Text('保存'),
            onPressed: () {},
          ),
        ],
      ),
      body: InitHasLoadingHelp(
        init: () async {
          Future.delayed(Duration(seconds: 1));
        },
        child: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: '姓名'),
                controller: formController.name,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                    type: HelpValidatorType.require,
                    dealMsg: () => '必填'
                  )
                ]),
                autovalidate: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
