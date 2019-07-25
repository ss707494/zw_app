import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/common/apiPath.dart';
import 'package:zw_app/common/http.dart';
import 'package:zw_app/component/carousel_slider_indicator/carousel_slider_indicator.dart';
import 'package:zw_app/component/image_err_help.dart';
import 'package:zw_app/component/init_help/init_help.dart';
import 'package:zw_app/component/loading_help/loading_help.dart';
import 'package:zw_app/model/subject_selection.dart';
import 'package:zw_app/view/main_page/home/classifications/component/product_card/product_card.dart';

class SubjectSelection extends StatelessWidget {
  final ScrollController scrollViewController;

  const SubjectSelection({Key key, this.scrollViewController}) : super(key: key);

  getData(context) async {
    final subjectSelectionModel = Provider.of<SubjectSelectionModel>(context);
    if (subjectSelectionModel.list.length > 0) return;
    var res = await httpPost(context, getMayLikeListPath);
    subjectSelectionModel.list = res.data['data'] ?? [];
  }

  buildCard(item) => Card(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 120,
                child: CarouselSliderIndicator(
                  aspectRatio: 1 / 1,
                  items: [
                    ...item['Picture']?.length != 0
                        ? item['Picture']
                            ?.map((e) => Container(
                                  child: Image.network(
                                    '$e',
                                    fit: BoxFit.fill,
                                  ),
                                ))
                            ?.toList()
                        : []
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(item['F_CNameC']),
                            Container(
                              width: 10,
                            ),
                            Text('${item['F_CWeight']}${item['F_CPCompany']}'),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withAlpha(200),
                          ),
                          child: Text(
                            '当前剩余: 231',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
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
                                      fontSize: 17, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          child: RaisedButton(
                            padding: EdgeInsets.all(2),
                            elevation: 1,
                            color: Colors.red,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                Text(
                                  '加入购物车',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
//                    icon: Icon(Icons.shopping_cart,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InitHelp(
      init: () {
        getData(context);
      },
      child: LoadingHelp(
        path: getMayLikeListPath,
        child: Consumer<SubjectSelectionModel>(
          builder: (_, subjectSelectionModel, __) => Container(
//            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: ListView(
              children: [
                Container(
                  height: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: ImageErrHelp(
                          imageUrl: 'https://images.pexels.com/photos/1492219/pexels-photo-1492219.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                        ),
                      ),
                      Container(
                        height: 140 * 1.8,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: ListView.builder(
                          itemCount: subjectSelectionModel.list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: 100 * 1.8,
                            child: ProductCard(
                              item: subjectSelectionModel.list[index],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
