import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/group_product.dart';

class FilterDraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<GroupProductModel>(context);
    return Column(
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              '筛选',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey.withAlpha(150),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    '价格',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '最低价',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '最低价',
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    '品牌',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 10 / 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    ['乐视', '1'],
                    ['品客', '2'],
                    ['乐视'],
                    ['品客'],
                    ['乐视'],
                    ['品客'],
                    ['乐视'],
                    ['品客'],
                  ]
                      .map((e) => Container(
                            child: productModel.choseBrand.contains(e[0])
                                ? RaisedButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      productModel.removeChoseBrand(e[0]);
                                    },
                                    child: Text(e[0]),
                                  )
                                : RaisedButton(
                                    onPressed: () {
                                      productModel.addChoseBrand(e[0]);
                                    },
                                    child: Text(e[0]),
                                  ),
                          ))
                      .toList(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    '折扣',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 10 / 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    ['低于5折', '1'],
                    ['低于7折', '2'],
                    ['低于8折'],
                    ['低于9折'],
                  ]
                      .map((e) => Container(
                    child: productModel.choseBrand.contains(e[0])
                        ? RaisedButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.red,
                      onPressed: () {
                        productModel.removeChoseBrand(e[0]);
                      },
                      child: Text(e[0]),
                    )
                        : RaisedButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        productModel.addChoseBrand(e[0]);
                      },
                      child: Text(e[0]),
                    ),
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey.withAlpha(130),
        ),
        ButtonTheme(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {},
                  child: Text('重置'),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {},
                  child: Text('确定'),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
