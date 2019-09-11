import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/confirm_dialog/confirm_dialog.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/pay_card_entity.dart';
import 'package:zw_app/graphql_document/pay_card.dart';
import 'package:zw_app/model/pay_card.dart';
import 'package:zw_app/view/main_page/user_center/edit_pay_card.dart';

class MyPayCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PayCardModel payCardModel = Provider.of<PayCardModel>(context);
//    FormTextEditingController addressController = payCardModel.formTextEditingController;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的信用卡'),
        actions: <Widget>[
          FlatButton(
            child: Text('添加信用卡'),
            onPressed: () {
              mainNavigationKey.currentState.push(MaterialPageRoute(
                builder: (context) => EditPayCard(),
              ));
            },
          ),
        ],
      ),
      body: InitHasLoadingHelp(
        path: getPayCardList,
        init: () async {
          await payCardModel.getListData(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: payCardModel.list.length,
                itemBuilder: (context, index) {
                  PayCardEntity item = payCardModel.list[index];
                  return ListTile(
                    leading: Container(
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (v) {
                              payCardModel.defaultId = item.id;
                            },
                            value: item.id,
                            groupValue: payCardModel.defaultId,
                          ),
                          ImageErrHelp(
                            imageUrl: '',
                          ),
                        ],
                      ),
                    ),
                    title: Text(item.userName),
                    subtitle:
                        Text('${item.number}'),
                    trailing: Container(
                      width: 70,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 35,
                            child: IconButton(
                              onPressed: () {
                                payCardModel.setDetailItem(context, item: item);
                                mainNavigationKey.currentState.push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditPayCard(id: item.id)));
                              },
                              icon: Icon(Icons.edit),
                              iconSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 35,
                            child: IconButton(
                              onPressed: () async {
                                showConfirmDialog(
                                    context: context,
                                    content: Text('确认删除吗?'),
                                    handleOk: () async {
                                      var res = await payCardModel.deleteItem(
                                        context,
                                        id: item.id,
                                      );
                                      if (res['flag'] == 1) {
                                        Fluttertoast.showToast(msg: '操作成功');
                                        payCardModel.getListData(context);
                                      }
                                      return res['flag'] == 1;
                                    });
                              },
                              icon: Icon(Icons.delete),
                              iconSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.red,
                child: Text('设置信用卡', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  payCardModel.setDefaultId(context, payCardModel.defaultId);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
