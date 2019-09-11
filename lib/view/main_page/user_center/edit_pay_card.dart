import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/validator_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/graphql_document/pay_card.dart';
import 'package:zw_app/model/pay_card.dart';

class EditPayCard extends StatelessWidget {

  final String id;

  const EditPayCard({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PayCardModel payCardModel = Provider.of<PayCardModel>(context);
    PayCardFormTextEditingController formController =
        payCardModel.formTextEditingController;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('信用卡详情'),
        actions: <Widget>[
          FlatButton(
            child: Text('保存'),
            onPressed: () async {
              var res = await payCardModel.submit(context);
              print(res);
              if (res['flag'] == 1) {
                payCardModel.getListData(context);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: InitHasLoadingHelp(
        path: savePayCardDoc,
        init: () async {
        },
        dispose: () {
          payCardModel.setDetailItem(context, item: null);
        },
        child: Form(
          key: payCardModel.formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: '信用卡号'),
                controller: formController.number,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: payCardModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '四位号码'),
                controller: formController.code,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: payCardModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '姓名'),
                controller: formController.userName,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: payCardModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '具体地址'),
                controller: formController.addressDetail,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: payCardModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '邮政编码'),
                controller: formController.zipCode,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: payCardModel.isAutoValidate,
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
                autovalidate: payCardModel.isAutoValidate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '联系方式'),
                controller: formController.contact,
                validator: helpValidator(types: [
                  HelpValidatorDescription(
                      type: HelpValidatorType.require,
                      dealMsg: () => '必填'
                  )
                ]),
                autovalidate: payCardModel.isAutoValidate,
              ),
              Container(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
