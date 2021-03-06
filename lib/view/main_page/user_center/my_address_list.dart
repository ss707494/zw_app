import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/component/confirm_dialog/confirm_dialog.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/address_item_entity.dart';
import 'package:zw_app/graphql_document/address.dart';
import 'package:zw_app/model/address.dart';
import 'package:zw_app/view/main_page/user_center/edit_address.dart';

class MyAddressList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddressModel addressModel = Provider.of<AddressModel>(context);
//    FormTextEditingController addressController = addressModel.formTextEditingController;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的地址'),
        actions: <Widget>[
          FlatButton(
            child: Text('添加地址'),
            onPressed: () {
              mainNavigationKey.currentState.push(MaterialPageRoute(
                builder: (context) => EditAddress(),
              ));
            },
          ),
        ],
      ),
      body: InitHasLoadingHelp(
        path: getAddressList,
        init: () async {
          await addressModel.getListData(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: addressModel.list.length,
                itemBuilder: (context, index) {
                  AddressItemEntity item = addressModel.list[index];
                  return ListTile(
                    leading: Container(
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (v) {
                              addressModel.defaultId = item.id;
                            },
                            value: item.id,
                            groupValue: addressModel.defaultId,
                          ),
                          ImageErrHelp(
                            imageUrl: '',
                          ),
                        ],
                      ),
                    ),
                    title: Text(item.address),
                    subtitle:
                        Text('${item.province} ${item.city} ${item.district}'),
                    trailing: Container(
                      width: 70,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 35,
                            child: IconButton(
                              onPressed: () {
                                addressModel.setDetailItem(context, item: item);
                                mainNavigationKey.currentState.push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditAddress(id: item.id)));
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
                                      var res = await addressModel.deleteItem(
                                        context,
                                        id: item.id,
                                      );
                                      if (res['flag'] == 1) {
                                        Fluttertoast.showToast(msg: '操作成功');
                                        addressModel.getListData(context);
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
                child: Text('设置默认地址', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  addressModel.setDefaultId(context, addressModel.defaultId);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
