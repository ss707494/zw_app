import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/entity/product_item_entity.dart';
import 'package:zw_app/model/shopping_cart.dart';

class ProductCard extends StatelessWidget {
  final ProductItemEntity item;

  const ProductCard({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoppingCartModel shoppingCartModel = Provider.of<ShoppingCartModel>(context);
//    print(item);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              child: CarouselSliderIndicator(
                aspectRatio: 1 / 1,
                items: [
                  ...(item.imgs?.length ?? 0) > 0
                      ? item.imgs
                          ?.map((e) => ImageErrHelp(
                                imageUrl: e.url,
                              ))
                          ?.toList()
                      : []
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Text(item.name),
                  Spacer(),
                  Text('${item.weight}${item.unit}'),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '¥${item.priceMarket}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '¥${item.priceOut}',
                            style: TextStyle(fontSize: 16, color: Colors.red),
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
                    onPressed: () async {
                      await shoppingCartModel.addToShopCart(context, productId: item.id);
                    },
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
