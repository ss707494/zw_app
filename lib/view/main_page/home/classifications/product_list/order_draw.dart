
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/model/product.dart';

class OrderDraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                '排序',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.withAlpha(150),
            ),
            ...[
              [ProductOrderType.discount, '打折'],
              [ProductOrderType.volume, '销量'],
              [ProductOrderType.isNew, '最新上架'],
              [ProductOrderType.priceHigh, '价格由低到高'],
              [ProductOrderType.priceLow, '价格由高到低'],
            ]
                .map((e) => RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: e[0],
                      groupValue: productModel.order,
                      onChanged: (v) {
                        productModel.order = v;
                      },
                      title: Text(e[1]),
                    ))
                .toList(),
          ],
        );
  }
}
