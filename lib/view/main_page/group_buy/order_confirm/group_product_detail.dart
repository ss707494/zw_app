import 'package:flutter/material.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_has_loading_help/init_has_loading_help.dart';
import 'package:zw_app/entity/product_item_entity.dart';

class GroupProductDetail extends StatefulWidget {
  final ProductItemEntity product;

  const GroupProductDetail({Key key, this.product}) : super(key: key);

  @override
  _GroupProductDetailState createState() => _GroupProductDetailState();
}

class _GroupProductDetailState extends State<GroupProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('拼团'),
      ),
      body: InitHasLoadingHelp(
        init: () async {
        },
        child: ListView(
          children: <Widget>[
            CarouselSliderIndicator(
              items: [
                ...widget?.product?.imgs
                    ?.map((e) => ImageErrHelp(
                  imageUrl: e.url,
                ))
                    ?.toList() ??
                    []
              ],
            ),
          ],
        ),
      ),
    );
  }
}
