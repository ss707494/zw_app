import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zw_app/common/secure_storage.dart';
import 'package:zw_app/common/storeModel/storeModel.dart';
import 'package:zw_app/type__graphql/art_graphql/art_graphql_query.dart';
import 'package:zw_app/view/test_page/use_hooks/inner_hooks.dart';

class PaTest {
  String paName = 'paName';
}

class PaTestAction {
  changePaName<T extends PaTest>(HelpAction<T> h) =>
          (String name) {
        h.setData(h.state..paName = name);
        return name;
      };
}

class SsState with PaTest {
  String name = '123';
  int number = 1;
  List<PromoCodeList$Query$PromoCode> promoCodeList = [];
}

class SsActions with PaTestAction {
  doOne(String value) =>
          (HelpAction<SsState> helpAction) {
        helpAction.setData(helpAction.state..name = value);
      };

  addNumber(int num) =>
          (HelpAction<SsState> helpAction) {
        helpAction
            .setData(helpAction.state..number = num + helpAction.state.number);
      };

  addNumAsync(int num) =>
          (HelpAction<SsState> helpAction) async {
        await Future.delayed(Duration(seconds: 1));
        helpAction.setData(
          helpAction.state..number += num,
        );
      };

  testQuery() =>
          (HelpAction<SsState> h) async {
        final res = await h.query(PromoCodeListQuery());
        print(res?.data?.promoCodeList);
        h.setData(h.state..promoCodeList = res?.data?.promoCodeList ?? []);
      };

  clearToken(HelpAction<SsState> h) =>
          () async {
        await setStorage(key: 'token', value: '123');
      };

  testLongApi(HelpAction<SsState> h) =>
          () async {
        print('${TestLongApiQuery().toString()}');
        print('$TestLongApiQuery');
        print(TestLongApiQuery().toString() == '$TestLongApiQuery');
        final res = await h.query(TestLongApiQuery());
        print(res?.data?.testLongApi);
        return res?.data?.testLongApi;
      };

}

ModelData<SsState, SsActions> test = ModelData()
  ..name = 'name'
  ..state = SsState()
  ..actions = SsActions();

class CounterTest extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print('init CounterTest');
    print(new DateTime.now().millisecondsSinceEpoch);
    final mm = useState(1);
    final model = useStoreModel(test);

    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                height: 200,
              ),
              ...model.state.promoCodeList.map((i) => Text('${i.id}')),
              GestureDetector(
                onTap: () {
                  model.actions.doOne('12344')(model.helpAction);
                },
                child: Text(model.state.name + model.state.paName),
              ),
              OutlineButton(
                onPressed: () {
                  model.actions
                      .changePaName(model.helpAction)(model.state.paName + 'P');
                },
                child: Text('changePaName'),
              ),
              Text(model.state.number.toString()),
              OutlineButton(
                onPressed: () {
                  model.actions.addNumber(1)(model.helpAction);
                },
                child: Text('addNumber'),
              ),
              FlatButton(
                onPressed: () {
                  model.actions.addNumber(1)(model.helpAction);
                },
                child: Text('addNumber'),
              ),
              Text('number useState'),
              Text(''),
              RaisedButton(
                onPressed: () {
                  mm.value = mm.value + 1;
                },
                child: Text('addNumber useState'),
              ),
              Text('${model.getLoad(TestLongApiQuery)}'),
              RaisedButton(
                onPressed: () async {
                  String res = await model.actions.testLongApi(model.helpAction)();
                  Fluttertoast.showToast(msg: res);
                },
                child: Text('testLongApi'),
              ),
              RaisedButton(
                onPressed: () {
                  model.actions.clearToken(model.helpAction)();
                },
                child: Text('clearToken'),
              ),
              CounterInner(),
            ],
          ),
        ),
      ),
    );
  }
}
