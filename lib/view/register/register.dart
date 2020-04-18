import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/router_help.dart';
import 'package:zw_app/model/register.dart';

class Register extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final autoValidate = useState(false);
    RegisterModel registerModel = Provider.of<RegisterModel>(context);
    useEffect((){
      return () {
        registerModel.clearForm();
      };
    }, []);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Form(
          key: registerModel.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: '用户名',
                  ),
                  controller: registerModel.nameController,
                  validator: (v) => v == '' ? '必填项' : null,
                  autovalidate: autoValidate.value,
                ),
                Container(height: 20),
                TextFormField(
                  obscureText: !registerModel.showPassword,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: '密码',
                    suffixIcon: IconButton(
                      icon: Icon(registerModel.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        registerModel.showPassword = !registerModel.showPassword;
                      },
                    ),
                  ),
                  controller: registerModel.passwordController,
                  validator: (v) => v == '' ? '必填项' : null,
                  autovalidate: autoValidate.value,
                ),
                Container(height: 20),
                TextFormField(
                  obscureText: !registerModel.showPassword,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: '确认密码',
                    suffixIcon: IconButton(
                      icon: Icon(registerModel.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        registerModel.showPassword = !registerModel.showPassword;
                      },
                    ),
                  ),
                  controller: registerModel.confirmPasswordController,
                  validator: (v) => v == '' ? '必填项' : null,
                  autovalidate: autoValidate.value,
                ),
                Container(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: '姓名',
                  ),
                  controller: registerModel.userName,
                  validator: (v) => v == '' ? '必填项' : null,
                  autovalidate: autoValidate.value,
                ),
                Container(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: '电话',
                  ),
                  controller: registerModel.userPhone,
                  validator: (v) => v == '' ? '必填项' : null,
                  autovalidate: autoValidate.value,
                ),
                Container(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: '邮箱',
                  ),
                  controller: registerModel.userEmail,
                  validator: (v) => v == '' ? '必填项' : null,
                  autovalidate: autoValidate.value,
                ),
                Container(height: 20),
                RaisedButton(
                  child: Text('注册'),
                  onPressed: () async {
                    if (registerModel.formKey.currentState.validate()) {
                      autoValidate.value = false;
                      await registerModel.submit(context);
                    } else {
                      autoValidate.value = true;
                    }
                  },
                ),
                RaisedButton(
                  child: Text('返回'),
                  onPressed: () async {
                    if (mainNavigationKey.currentState.canPop()) {
                      mainNavigationKey.currentState.pop();
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
