
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zw_app/common/storeModel/storeModel.dart';
import 'package:zw_app/view/test_page/use_hooks/use_hooks.dart';

class CounterInner extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print('init CounterInner');
    print(new DateTime.now().millisecondsSinceEpoch);
    final model = useStoreModel(test);

    return Container(
      child: Column(
        children: <Widget>[
          Text('Inner', style: TextStyle(fontSize: 20),),
          Text(model.state.number.toString()),
          OutlineButton(
            onPressed: () {model.actions.addNumAsync(1)(model.helpAction);},
            child: Text('add Async'),
          ),
          OutlineButton(
            onPressed: () {
              model.actions.testQuery()(model.helpAction);
            },
            child: Text('test query'),
          ),
        ],
      ),
    );
  }
}
