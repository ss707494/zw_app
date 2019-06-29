import 'package:flutter/material.dart';
import 'package:zw_app/common/http.dart';

class Home extends StatelessWidget {

  getLogin(context) async {
    var res = await dio.post('http://128.14.236.90:4460/api/login', data: {
      'name': 'admin',
      'password': '123456'
    });
    final snackBar = new SnackBar(content: new Text(res.toString()));
    Scaffold.of(context).showSnackBar(snackBar);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    const dsf = [1,2];
    final fgt = [...dsf];
    return Scaffold(
      appBar: AppBar(title: Text('test http'),),
      body: Center(
        child: Builder(
          builder: (context) {
            return RaisedButton(
              child: Text('123'),
              onPressed: () {
                getLogin(context);
              },
            );
          },
        ),
      ),
    );
  }
}
