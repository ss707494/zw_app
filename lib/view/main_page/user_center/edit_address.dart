import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/validator_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/model/address.dart';

class EditAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddressModel addressModel = Provider.of<AddressModel>(context);
    FormTextEditingController formController =
        addressModel.formTextEditingController;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('地址详情'),
        actions: <Widget>[
          FlatButton(
            child: Text('保存'),
            onPressed: () async {
              var res = await addressModel.submit(context);
              print(res);
              if (res['flag'] == 1) {
                addressModel.getListData(context);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: InitHasLoadingHelp(
        init: () async {
          Future.delayed(Duration(seconds: 1));
        },
        child: Form(
          key: addressModel.formKey,
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
                autovalidate: addressModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '详细地址'),
                controller: formController.address,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: addressModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '州'),
                controller: formController.province,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: addressModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '城市'),
                controller: formController.city,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: addressModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '地区'),
                controller: formController.district,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: addressModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '邮编'),
                controller: formController.zip,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: addressModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '联系方式'),
                controller: formController.contactInformation,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: addressModel.isAutoValidate,
              ),
              Container(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
