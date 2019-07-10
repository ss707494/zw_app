import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/login.dart';
import 'package:zw_app/view/test_page/provider_sample/ss_provider/ss_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

final _formKey = GlobalKey<FormState>();

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            DropdownButtonFormField(
              decoration: InputDecoration(errorText: 'errtest'),
              items: ['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: InputDecoration(
                helperText: 'lskdjf',
              ),
              validator: (v) {
                if (v.isEmpty) {
                  return 'fefefefefe';
                }
              },
            ),
            DropdownButton<String>(
              hint: Text('请选择'),
              value: null,
              onChanged: (String newValue) {
                print(newValue);
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CarouselSlider(
                height: 400.0,
                viewportFraction: 1.0,
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
//                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Text(
                            'text $i',
                            style: TextStyle(fontSize: 16.0),
                          ));
                    },
                  );
                }).toList(),
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.only(
//                left: 20,
//                right: 20,
//                top: 10,
//              ),
//              child: Consumer<SSModal>(
//                builder: (BuildContext context, value, Widget child) =>
//                    TextField(
//                      decoration: InputDecoration(labelText: '${value.title}'),
//                    ),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.only(
//                left: 20,
//                right: 20,
//                top: 10,
//              ),
//              child: Consumer<LoginModel>(
//                builder: (context, loginModel, _) => TextField(
//                      onChanged: (v) =>
//                          Provider.of<SSModal>(context).changeTitle(v),
//                      obscureText: !loginModel.showPassword,
//                      decoration: InputDecoration(
//                        suffix: IconButton(
//                          icon: Icon(loginModel.showPassword
//                              ? Icons.visibility
//                              : Icons.visibility_off),
//                          onPressed: () {
//                            loginModel.showPassword = !loginModel.showPassword;
//                          },
//                        ),
//                      ),
//                    ),
//              ),
//            ),
            RaisedButton(
              child: Text('登录'),
              onPressed: () {
                _formKey.currentState.widget;
              },
            ),
            RaisedButton(
              child: Text('changeNum'),
              onPressed: () {
                Provider.of<SSModal>(context).changeNumber(232323);
              },
            ),
          ],
        ),
      ),
    );
  }
}
