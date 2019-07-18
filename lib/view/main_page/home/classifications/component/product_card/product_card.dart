import 'package:flutter/material.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';

class ProductCard extends StatelessWidget {
  final item;

  const ProductCard({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    item['Picture'];
    print(item['Picture']);
    item['Picture'].forEach((e) {
      print(e);
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
//            Text('${item['Picture']}'),
            Expanded(
              flex: 5,
              child: CarouselSliderIndicator(
                height: null,
                items: [1]
                    ?.map((e) => Container(
//                          child: Image.network(
//                            '$e',
//                            fit: BoxFit.fill,
//                            width: double.infinity,
//                          ),
                child: Text('123123'),
                        ))
                    ?.toList() ?? [Container()],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Text(item['F_CNameC']),
                  Spacer(),
                  Text('${item['F_CWeight']}${item['F_CPCompany']}'),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '¥${item['F_CPUnitPriceMarket']}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '¥${item['F_CPUnitPriceOut']}',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.red
                            ),
                          ),
                        ),
                      ],
                    ),
                    alignment: AlignmentDirectional.bottomCenter,
                    padding: EdgeInsets.only(bottom: 8),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    elevation: 1,
                    mini: true,
                    backgroundColor: Colors.red,
//                    fillColor: Colors.red.withAlpha(90),
                    onPressed: () {},
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.shopping_cart,
                    ),
//                    icon: Icon(Icons.shopping_cart,),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
