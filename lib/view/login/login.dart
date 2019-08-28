import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/login.dart';

final _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool autovalidate = false;

  @override
  Widget build(BuildContext context) {
    LoginModel loginModel = Provider.of<LoginModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: '用户名',
                  ),
                  controller: loginModel.nameController,
                  validator: (v) => v == '' ? '必填项' : null,
                  autovalidate: autovalidate,
                ),
                Container(height: 20),
                TextFormField(
                  obscureText: !loginModel.showPassword,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: '密码',
                    suffixIcon: IconButton(
                      icon: Icon(loginModel.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        loginModel.showPassword = !loginModel.showPassword;
                      },
                    ),
                  ),
                  controller: loginModel.passwordController,
                  validator: (v) => v == '' ? '必填项' : null,
                  autovalidate: autovalidate,
                ),
                Container(height: 20),
                RaisedButton(
                  child: Text('登录'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      autovalidate = false;
                      var res = await loginModel.login(context);
                      print(res);
                    } else {
                      setState(() {
                        autovalidate = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
